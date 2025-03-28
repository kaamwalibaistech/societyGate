import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:my_society/api/api_repository.dart';

import 'constents/local_storage.dart';
import 'dashboard/visitors/network/add_visiters_api.dart';
import 'models/login_model.dart';

class ManualVisitorsForm extends StatefulWidget {
  const ManualVisitorsForm({super.key});

  @override
  State<ManualVisitorsForm> createState() => _ManualVisitorsFormState();
}

class _ManualVisitorsFormState extends State<ManualVisitorsForm> {
  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  late String flatId, societyId, requestBy;
  late String name, phone, relation, gender, purpose, visitingDate;
  AddVisitoModel? _addVisitoModel;
  LoginModel? _loginModel;
  late String qrData;
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
                      ApiRepository apiRepository = ApiRepository();
                      _loginModel = LocalStoragePref().getLoginModel();
                      _formKey.currentState!.save();
                      addVisitors();
                      apiRepository.manualAproveApi(
                          _addVisitoModel!.uniqueCode.toString(),
                          _loginModel!.user!.userId.toString(),
                          "entry");

                      Fluttertoast.showToast(msg: "Added Successfully");
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Entry"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        // qrData = _addVisitoModel?.uniqueCode ?? "Something Wrong!";
      });

      // qrCode(context);
    } catch (e) {
      throw Exception(e);
    }
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
