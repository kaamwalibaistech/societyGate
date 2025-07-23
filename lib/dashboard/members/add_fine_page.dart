import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import 'package:image_picker/image_picker.dart';
import 'package:society_gate/dashboard/members/network/addfine_api.dart';

class AddFinePage extends StatefulWidget {
  final dynamic details;
  const AddFinePage({super.key, required this.details});

  @override
  State<AddFinePage> createState() => _AddFinePageState();
}

class _AddFinePageState extends State<AddFinePage> {
  final finetitle = TextEditingController();
  final fineAmount = TextEditingController();
  final finereason = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  DateTime? selectedDate;
  final ImagePicker _picker = ImagePicker();

  File? _image;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null &&
        picked.isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
      setState(() {
        selectedDate = picked;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Selected time should be greater then Today.");
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });

        log("Size od selected Image : ${_image!.lengthSync()}");
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No image selected.')),
          );
        }
      }
    } on PlatformException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
      log('PlatformException: ${e.code} - ${e.message}');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred.')),
        );
      }
      log('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFE53935); // Match Add Fine button color
    const backgroundColor = Color(0xFFFDF6F9); // Light pink background

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Add Fine",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // User details card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: CachedNetworkImageProvider(widget
                                .details.profileImage ??
                            "https://ui-avatars.com/api/?background=random&name=${widget.details.uname}."),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.details.uname.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.details.uemail.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.verified, color: Colors.green)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Add Fine form
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: fineAmount,
                          decoration: InputDecoration(
                            labelText: "Fine Amount",
                            prefixText: "₹ ",
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value == "") {
                              return "This feild is required.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: finetitle,
                          decoration: InputDecoration(
                            labelText: "Fine Name",
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value == "") {
                              return "This feild is required.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          maxLines: 3,
                          controller: finereason,
                          decoration: InputDecoration(
                            labelText: "Reason for Fine",
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value == "") {
                              return "This feild is required.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: InputDecoration(
                            labelText: "Fine Due Date",
                            suffixIcon: const Icon(Icons.calendar_today),
                            hintText: selectedDate == null
                                ? "Select Date"
                                : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          // validator: (value) {
                          //   if (value == null || value == "") {
                          //     return "This feild is required.";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => showImagePickerOptions(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor.withOpacity(0.1),
                            foregroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.attach_file),
                          label: const Text("Add Attachment"),
                        ),
                        if (_image != null)
                          Chip(
                            label: Text(
                              path.basename(_image!.path),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            backgroundColor: primaryColor.withOpacity(0.1),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            deleteIconColor: primaryColor,
                            onDeleted: () {
                              setState(() {
                                _image = null;
                              });
                            },
                          )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: const BorderSide(color: primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_form.currentState != null &&
                            _form.currentState!.validate() &&
                            selectedDate != null) {
                          EasyLoading.show();
                          final int? status = await addFineApi(
                            widget.details.societyId.toString(),
                            widget.details.userId.toString(),
                            widget.details.flatId.toString(),
                            finetitle.text,
                            finereason.text,
                            fineAmount.text,
                            selectedDate.toString(),
                            _image?.path ?? "",
                          );
                          if (status == 200) {
                            Fluttertoast.showToast(
                                msg: "Fine added successfully!");
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Something went wrong, try again!!");
                          }
                          EasyLoading.dismiss();
                        } else {
                          Fluttertoast.showToast(
                              msg: "Fill all the required feilds.");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Add Fine"),
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

  void showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select Image Source",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListTile(
                  iconColor: Colors.redAccent,
                  textColor: Colors.redAccent.shade700,
                  leading: const Icon(
                    Icons.photo_library,
                  ),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  iconColor: Colors.blueAccent,
                  textColor: Colors.blueAccent.shade700,
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
