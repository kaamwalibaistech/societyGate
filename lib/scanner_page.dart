import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_society/api/api_constant.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/constents/sizedbox.dart';
import 'package:my_society/models/login_model.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _dialogShown = false;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!_dialogShown) {
        result = scanData;

        if (result?.rawBytes != null && result!.rawBytes!.isNotEmpty) {
          _dialogShown = true;
          controller.pauseCamera();
          showOptionDilog();
        }
      }
    });
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.greenAccent,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        _buildQrView(context),
        sizedBoxH30(context),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.14,
            child: const Text(
              "Society Gate",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ))
      ]),
    );
  }

  void successDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Container(
          padding: const EdgeInsets.only(top: 18),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              Lottie.asset("lib/assets/lottie_json/success.json",
                  repeat: false, height: 220),
              sizedBoxH30(context),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    controller?.resumeCamera();
                    _dialogShown = false;
                  },
                  child: const Text("Done"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showOptionDilog() {
    LoginModel? loginModel = LocalStoragePref().getLoginModel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Container(
          padding: const EdgeInsets.only(top: 18),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              SizedBox(
                height: 80,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    String watchmanId = loginModel!.user!.userId.toString();
                    log("${result!.code}  $watchmanId");
                    await aproveVisitor(
                        result!.code.toString(), watchmanId, "entry");
                  },
                  child: const Text("Entry"),
                ),
              ),
              sizedBoxH30(context),
              SizedBox(
                height: 80,
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    String watchmanId = loginModel!.user!.userId.toString();
                    log("${result!.code}  $watchmanId");
                    await aproveVisitor(
                        result!.code.toString(), watchmanId, "exit");
                  },
                  child: const Text("Exit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> aproveVisitor(
    String uniqueCode,
    String watchmanId,
    String action,
  ) async {
    String api = ApiConstant.aproveVisitor;
    String baseUrl = ApiConstant.baseUrl;
    Uri url = Uri.parse(baseUrl + api);

    final body = {
      'unique_code': uniqueCode,
      'watchman_id': watchmanId,
      'action': action,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: data['message']);

        if (data['status'] == 200) {
          //await Future.delayed(const Duration(milliseconds: 300));
          successDialog();
        } else {
          // await Future.delayed(const Duration(milliseconds: 300));
          failedDialog(data['message']);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error occurred: $e");
      Navigator.pop(context);
      controller?.resumeCamera();
      _dialogShown = false;
    }
  }

  void failedDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                padding: const EdgeInsets.only(top: 18),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    Text(
                      message,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 80,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          controller?.resumeCamera();
                          _dialogShown = false;
                        },
                        child: const Text(
                          "Close",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
