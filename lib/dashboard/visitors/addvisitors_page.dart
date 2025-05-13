import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../constents/local_storage.dart';
import '../../constents/sizedbox.dart';
import '../../models/login_model.dart';
import 'network/add_visiters_api.dart';
import 'visitors_bloc/visitors_bloc.dart';

class AddVisitorsPage extends StatefulWidget {
  const AddVisitorsPage({super.key});

  @override
  State<AddVisitorsPage> createState() => _AddVisitorsPageState();
}

class _AddVisitorsPageState extends State<AddVisitorsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  late String flatId, societyId, requestBy;
  late String name, phone, relation, gender, purpose, visitingDate;
  AddVisitoModel? _addVisitoModel;
  LoginModel? _loginModel;
  late String qrData;

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  getInitialData() {
    _loginModel = LocalStoragePref().getLoginModel();
    if (_loginModel != null) {
      setState(() {
        flatId = _loginModel!.user!.flatId.toString();
        societyId = _loginModel!.user!.societyId.toString();
        requestBy = _loginModel!.user!.userId.toString();
      });
    }
  }

  addVisitors() async {
    try {
      _addVisitoModel = await addVisitorApi(flatId, societyId, requestBy, name,
          phone, relation, gender, purpose, visitingDate);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_addVisitoModel?.message ?? "Failled"),
        backgroundColor: Colors.green,
      ));
      setState(() {
        qrData = _addVisitoModel?.uniqueCode ?? "Something Wrong!";
      });

      qrCode(context);
    } catch (e) {
      throw Exception(e);
    }
  }

  void qrCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Show this QR at the gate.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizedBoxH20(context),
              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200,
              ),
              sizedBoxH10(context),
              Text(qrData),
              sizedBoxH20(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<VisitorsBloc>().add(GetVisitorsEvent(
                          soceityId: societyId.toString(),
                          flatId: flatId.toString()));

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.done,
                      color: Colors.black,
                    ),
                    label: const Text("Done"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      shareQrImage(context, qrData);
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                    label: const Text("Share"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade200,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
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

      // Define sizes
      const qrSize = 400.0;
      const padding = 40.0;
      const totalSize = qrSize + padding * 2;

      // Create canvas
      final recorder = PictureRecorder();
      final canvas =
          Canvas(recorder, const Rect.fromLTWH(0, 0, totalSize, totalSize));

      // Fill background with white
      final bgPaint = Paint()..color = Colors.white;
      canvas.drawRect(const Rect.fromLTWH(0, 0, totalSize, totalSize), bgPaint);

      // Shift canvas to add white padding
      canvas.translate(padding, padding);

      // Draw QR in the center
      painter.paint(canvas, const Size(qrSize, qrSize));

      final picture = recorder.endRecording();
      final image = await picture.toImage(totalSize.toInt(), totalSize.toInt());
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visitor Entry Form"),
        backgroundColor: Colors.purple.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField("Name", (val) => name = val!),
                _buildTextField("Phone", (val) => phone = val!, isPhone: true),
                _buildTextField("Relation", (val) => relation = val!),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Gender"),
                  items: ["male", "female", "other"].map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (val) => gender = val!,
                ),
                _buildTextField("Visiting Purpose", (val) => purpose = val!),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: "Visiting Date"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2025),
                      lastDate: DateTime(2026),
                    );
                    if (picked != null) {
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      final selectedDate =
                          DateTime(picked.year, picked.month, picked.day);

                      if (selectedDate.isBefore(today)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Please select today's date or a future date"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      setState(() {
                        visitingDate = DateFormat('yyyy-MM-dd').format(picked);
                        _dateController.text = visitingDate;
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      addVisitors();
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved,
      {bool isPhone = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        counterText: "", // optional: hides character counter
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        if (isPhone && value.length != 10) return 'Phone must be 10 digits';
        return null;
      },
      onSaved: onSaved,
      keyboardType: isPhone ? TextInputType.number : TextInputType.text,
      maxLength: isPhone ? 10 : null,
    );
  }
}
