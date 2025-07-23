/*
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../api/api_constant.dart';
import '../constents/local_storage.dart';
import '../constents/sizedbox.dart';
import '../models/login_model.dart';

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
    String watchmanId = loginModel!.user!.userId.toString();
    String societyID = loginModel!.user!.societyId.toString();
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
                    // String watchmanId = loginModel!.user!.userId.toString();
                    log("${result!.code}  $watchmanId");
                    await aproveVisitor(result!.code.toString(), watchmanId,
                        "entry", societyID);
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
                    await aproveVisitor(
                        result!.code.toString(), watchmanId, "exit", societyID);
                    log("${result!.code}  $watchmanId");
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
    String societyId,
  ) async {
    String api = ApiConstant.aproveVisitor;
    String baseUrl = ApiConstant.baseUrl;
    Uri url = Uri.parse(baseUrl + api);

    final body = {
      'unique_code': uniqueCode,
      'watchman_id': watchmanId,
      'action': action,
      'society_id': societyId,
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
      // Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error occurred: $e");
      // Navigator.pop(context);
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

*/

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../api/api_constant.dart';
import '../constents/local_storage.dart';
import '../constents/sizedbox.dart';
import '../models/login_model.dart';

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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (!_dialogShown && scanData.code != null) {
        _dialogShown = true;
        result = scanData;
        await controller.pauseCamera();
        showActionDialog();
      }
    });
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width < 400 ? 250.0 : 350.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.amber,
        borderRadius: 12,
        borderLength: 32,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          _buildQrView(context),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            child: Column(
              children: [
                Text(
                  "Society Gate",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black45,
                        offset: Offset(1, 2),
                      )
                    ],
                  ),
                ),
                // sizedBoxH20(context),
                // Lottie.asset(
                //   "lib/assets/lottie_json/scan.json",
                //   height: 200,
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showActionDialog() async {
    LoginModel? loginModel = LocalStoragePref().getLoginModel();
    String watchmanId = loginModel?.user?.userId.toString() ?? "";
    String societyID = loginModel?.user?.societyId.toString() ?? "";

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          "Visitor Access",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          height: 180,
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: () => _handleAction("entry", watchmanId, societyID),
                icon: const Icon(Icons.login),
                label: const Text("Allow Entry"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _handleAction("exit", watchmanId, societyID),
                icon: const Icon(Icons.logout),
                label: const Text("Log Exit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleAction(
      String action, String watchmanId, String societyId) async {
    Navigator.pop(context);
    try {
      final response = await http.post(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.aproveVisitor),
        body: {
          'unique_code': result?.code ?? "",
          'watchman_id': watchmanId,
          'action': action,
          'society_id': societyId,
        },
      );

      final data = jsonDecode(response.body);
      Fluttertoast.showToast(msg: data['message']);

      if (response.statusCode == 200 && data['status'] == 200) {
        successDialog();
      } else {
        failedDialog(data['message']);
      }
    } catch (e) {
      failedDialog("An unexpected error occurred.");
    }
  }

  void successDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset("lib/assets/lottie_json/success.json",
                repeat: false, height: 180),
            const SizedBox(height: 20),
            const Text("Access Granted!", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                controller?.resumeCamera();
                _dialogShown = false;
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }

  void failedDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Failed"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                controller?.resumeCamera();
                _dialogShown = false;
              },
              child: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
