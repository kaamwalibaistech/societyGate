import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:society_gate/dashboard/visitors/visitors_bloc/visitors_bloc.dart';

import '../../constents/local_storage.dart';
import '../../constents/sizedbox.dart';
import '../../models/login_model.dart';
import '../../models/visitors_details_model.dart';
import 'edit_visitor.dart';
import 'network/visitor_delete.dart';
import 'visitor_view_bloc/visitors_view_bloc.dart';
import 'visitor_view_bloc/visitors_view_event.dart';
import 'visitor_view_bloc/visitors_view_state.dart';

class VisitorsDetailsPage extends StatefulWidget {
  final String visitorID;
  final String societyId;
  final String flatId;
  const VisitorsDetailsPage(
      {super.key,
      required this.visitorID,
      required this.societyId,
      required this.flatId});

  @override
  State<VisitorsDetailsPage> createState() => _VisitorsDetailsPage();
}

class _VisitorsDetailsPage extends State<VisitorsDetailsPage> {
  late String visitorId;
  LoginModel? loginModel;
  @override
  void initState() {
    super.initState();
    fetchVisitors();
  }

  fetchVisitors() {
    loginModel = LocalStoragePref().getLoginModel();

    setState(() {
      visitorId = widget.visitorID;
    });
    context
        .read<VisitorsDetailBloc>()
        .add(GetVisitorDetailEvent(visitorId: visitorId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text(
          "Visitors",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: SafeArea(
        child: BlocBuilder<VisitorsDetailBloc, VisitorsDetailState>(
          builder: (context, state) {
            if (state is VisitorsDetailInitialState) {
              return _buildShimmer();
            } else if (state is VisitorsDetailErrorState) {
              return _buildError(state.msg);
            } else if (state is VisitorsDetailSuccessState) {
              return buildVisitorUI(state.visitorsDetailModel);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildError(String msg) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('lib/assets/empty.jpg'),
        Text(
          msg,
          style: const TextStyle(color: Colors.red, fontSize: 20),
        ),
      ],
    );
  }

  Widget buildVisitorUI(VisitorsDetailModel? visitorsDetailModel) {
    String qrData = visitorsDetailModel?.data?.uniqueCode ?? "error";

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Show this QR at the Gate",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 200,
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    qrData,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.done),
                        label: const Text("Close"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          shareQrImage(context, qrData);
                        },
                        icon: const Icon(Icons.share),
                        label: const Text("Share"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade200,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          sizedBoxH10(context),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Center(
                      child: Text(
                        visitorsDetailModel?.data?.name ?? "No Name",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Center(
                      child: Text(
                        visitorsDetailModel?.data?.phone ?? "N/A",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _infoTile(
                            "Relation", visitorsDetailModel?.data?.relation),
                      ),
                      Expanded(
                          child: _infoTile(
                              "Gender", visitorsDetailModel?.data?.gender)),
                      Expanded(
                        child: _infoTile("Invited At",
                            visitorsDetailModel?.data?.visitingDate),
                      ),
                    ],
                  ),
                  sizedBoxH15(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _infoTile("Purpose",
                            visitorsDetailModel?.data?.visitingPurpose),
                      ),
                    ],
                  ),
                  sizedBoxH15(context),
                  _infoTile("Entry Time", visitorsDetailModel?.data?.entryTime),
                  sizedBoxH15(context),
                  _infoTile("Exit Time", visitorsDetailModel?.data?.exitTime),
                  // const SizedBox(height: 16),
                  // _infoTile(
                  //     "Purpose", visitorsDetailModel?.data?.visitingPurpose),
                ],
              ),
            ),
          ),
          sizedBoxH15(context),
          Visibility(
            visible: visitorsDetailModel?.data?.entryTime == null ||
                visitorsDetailModel?.data?.exitTime == null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditVisitor(
                                visitorsDetailModel: visitorsDetailModel)));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  label: const Text("Edit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Delete this visitor?"),
                              content:
                                  const Text("You can add this visitor again!"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel")),
                                TextButton(
                                    onPressed: () async {
                                      final deleted =
                                          await deleteVisitor(visitorId);
                                      if (deleted != null) {
                                        if (deleted.containsValue(200)) {
                                          context.read<VisitorsBloc>().add(
                                              GetVisitorsEvent(
                                                  soceityId: widget.societyId,
                                                  flatId: widget.flatId));

                                          Fluttertoast.showToast(
                                            msg: deleted["message"],
                                          );
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          // Navigator.pop(context);
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Try again!",
                                            backgroundColor: Colors.red);
                                      }
                                    },
                                    child: const Text("Delete"))
                              ],
                            ));
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          value ?? "—",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Future<void> shareQrImage(BuildContext context, String data) async {
    try {
      final qrValidationResult = QrValidator.validate(
        data: data,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.Q,
      );

      final qrCode = qrValidationResult.qrCode!;
      final painter = QrPainter.withQr(
        qr: qrCode,
        color: Colors.black,
        emptyColor: Colors.white,
        gapless: true,
        embeddedImageStyle: null,
      );

      final picData = await painter.toImageData(400);
      final bytes = picData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/qr_code.png').create();
      await file.writeAsBytes(bytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: "Show this QR at the gate.",
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
      log(e.toString());
    }
  }
}
