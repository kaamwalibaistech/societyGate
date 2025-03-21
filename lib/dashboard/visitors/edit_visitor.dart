import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/models/visitors_details_model.dart';

import '../../models/login_model.dart';

class EditVisitor extends StatefulWidget {
  final VisitorsDetailModel? visitorsDetailModel;
  const EditVisitor({super.key, required this.visitorsDetailModel});

  @override
  State<EditVisitor> createState() => _EditVisitorState();
}

class _EditVisitorState extends State<EditVisitor> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  late String flatId, societyId, requestBy;
  late String name, phone, relation, gender, purpose, visitingDate;
  LoginModel? _loginModel;

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
                _buildTextField(
                    "Name",
                    (val) => name = val!,
                    TextEditingController(
                        text: widget.visitorsDetailModel!.data!.name)),
                _buildTextField(
                    "Phone",
                    (val) => phone = val!,
                    isPhone: true,
                    TextEditingController(
                        text: widget.visitorsDetailModel!.data!.phone)),
                _buildTextField(
                    "Relation",
                    (val) => relation = val!,
                    TextEditingController(
                        text: widget.visitorsDetailModel!.data!.relation)),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "Gender"),
                  items: ["male", "female", "other"].map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (val) => gender = val!,
                ),
                _buildTextField(
                    "Visiting Purpose",
                    (val) => purpose = val!,
                    TextEditingController(
                        text:
                            widget.visitorsDetailModel!.data!.visitingPurpose)),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: "Visiting Date"),
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
                          SnackBar(
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
                      // method api call
                    }
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, Function(String?) onSaved, TextEditingController controller,
      {bool isPhone = false}) {
    //  TextEditingController controller
    // TextEditingController(text: "fdsfdsf");
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        counterText: "",
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
