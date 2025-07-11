// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
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
  final bool isEnteredThroughNavBar;
  const AddVisitorsPage({super.key, required this.isEnteredThroughNavBar});

  @override
  State<AddVisitorsPage> createState() => _AddVisitorsPageState();
}

class _AddVisitorsPageState extends State<AddVisitorsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController relationController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();

  late String flatId, societyId, requestBy;
  late String gender, visitingDate;
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
      _addVisitoModel = await addVisitorApi(
          flatId,
          societyId,
          requestBy,
          nameController.text,
          phoneController.text,
          relationController.text,
          gender,
          purposeController.text,
          visitingDate);
      if (_addVisitoModel != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_addVisitoModel?.message ?? "Failled"),
          backgroundColor: Colors.green,
        ));
        setState(() {
          qrData = _addVisitoModel?.uniqueCode ?? "Something Wrong!";
        });

        qrCode(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_addVisitoModel?.message ?? "Something went wrong!"),
          backgroundColor: Colors.red,
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void qrCode(BuildContext context) {
    EasyLoading.show();
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
                      if (widget.isEnteredThroughNavBar == true) {
                        Navigator.pop(context);
                        nameController.clear();
                        phoneController.clear();
                        relationController.clear();
                        purposeController.clear();
                        _dateController.clear();
                      } else {
                        context.read<VisitorsBloc>().add(GetVisitorsEvent(
                            soceityId: societyId.toString(),
                            flatId: flatId.toString()));
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                      EasyLoading.dismiss();
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
                      EasyLoading.dismiss();
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
    EasyLoading.dismiss();
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
      // backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text("Visitor Entry Form"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        // elevation: 4,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                sizedBoxH30(context),
                _buildTextField(
                    "Name", Icons.person, (val) => nameController.text = val!,
                    isName: true, controller: nameController),
                const SizedBox(height: 20),
                _buildTextField("Phone", Icons.phone_android,
                    (val) => phoneController.text = val!,
                    isPhone: true, controller: phoneController),
                const SizedBox(height: 20),
                _buildTextField("Relation", Icons.group,
                    (val) => relationController.text = val!,
                    controller: relationController),
                const SizedBox(height: 20),
                _buildDropdownField(),
                const SizedBox(height: 20),
                _buildTextField("Visiting Purpose", Icons.assignment,
                    (val) => purposeController.text = val!,
                    controller: purposeController),
                const SizedBox(height: 20),
                _buildDatePicker(),
                const SizedBox(height: 30),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Container(
                //     height: 80,
                //     width: 200,
                //     decoration: BoxDecoration(
                //         color: Colors.deepPurpleAccent,
                //         borderRadius: BorderRadius.circular(10)),
                //   ),
                // ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      addVisitors(); // your submission method
                    }
                  },
                  icon: const Icon(Icons.mail),
                  label: const Text(
                    "Invite Now",
                    style: TextStyle(fontSize: 25),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    // maximumSize: Size(300, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    Function(String?) onSaved, {
    bool isPhone = false,
    bool isName = false,
    required TextEditingController controller,
  }) {
    final FlutterNativeContactPicker _contactPicker =
        FlutterNativeContactPicker();
    // List<Contact>? _contacts;
    // String? _selectedPhoneNumber;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurpleAccent),
        suffixIcon: isName
            ? IconButton(
                onPressed: () async {
                  final contact = await _contactPicker.selectContact();
                  String rawNumber = contact?.phoneNumbers?.first ?? "";
                  String cleanedNumber =
                      rawNumber.replaceAll(RegExp(r'\D'), '');
                  if (cleanedNumber.startsWith('91') &&
                      cleanedNumber.length > 10) {
                    cleanedNumber = cleanedNumber.substring(2);
                  }
                  setState(() {
                    nameController.text = contact?.fullName ?? "";
                    phoneController.text = cleanedNumber;
                  });

                  log(contact?.selectedPhoneNumber ?? "00");
                },
                icon: const Icon(Icons.contacts_rounded,
                    color: Colors.deepPurpleAccent))
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
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

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Gender",
        prefixIcon: const Icon(Icons.wc, color: Colors.deepPurple),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
      items: ["Male", "Female", "Other"].map((value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (val) => gender = val!,
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select gender' : null,
    );
  }

  Widget _buildDatePicker() {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        labelText: "Visiting Date",
        prefixIcon:
            const Icon(Icons.calendar_today, color: Colors.deepPurpleAccent),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
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
          final selectedDate = DateTime(picked.year, picked.month, picked.day);

          if (selectedDate.isBefore(today)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please select today's date or a future date"),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          setState(() {
            visitingDate = DateFormat('dd-MM-yyyy').format(picked);
            _dateController.text = visitingDate;
          });
        }
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select a date' : null,
    );
  }
}
