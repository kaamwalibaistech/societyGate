import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../api/api_repository.dart';
import '../constents/local_storage.dart';
import '../dashboard/visitors/network/add_visiters_api.dart';
import '../dashboard/visitors/visitors_bloc/visitors_bloc.dart';
import '../models/flat_id_model.dart';
import '../models/login_model.dart';

class ManualVisitorsForm extends StatefulWidget {
  const ManualVisitorsForm({super.key});

  @override
  State<ManualVisitorsForm> createState() => _ManualVisitorsFormState();
}

class _ManualVisitorsFormState extends State<ManualVisitorsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController flatNoController = TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController floorNoController = TextEditingController();

  late String flatId, societyId, requestBy;
  late String name, phone, relation, gender, purpose, visitingDate;

  AddVisitoModel? _addVisitoModel;
  LoginModel? _loginModel;

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  getInitialData() {
    _loginModel = LocalStoragePref().getLoginModel();
    if (_loginModel != null) {
      flatId = _loginModel!.user!.flatId.toString();
      societyId = _loginModel!.user!.societyId.toString();
      requestBy = _loginModel!.user!.userId.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        title: const Text("Manual Visitor Entry"),
        backgroundColor: const Color(0xFFFF9933),
        foregroundColor: Colors.white,
        centerTitle: true,
        // elevation: 3,
      ),
      body: SingleChildScrollView(
        child: Card(
          // shadowColor: const Color(0xFFFF9933),
          color: Colors.amber.shade50,
          surfaceTintColor: const Color(0xFFFF9933),
          margin: EdgeInsets.all(20),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("Name", Icons.person, (val) => name = val!),
                  const SizedBox(height: 16),
                  _buildTextField(
                      "Phone", Icons.phone_android, (val) => phone = val!,
                      isPhone: true),
                  const SizedBox(height: 16),
                  _buildTextField(
                      "Relation", Icons.group, (val) => relation = val!),
                  const SizedBox(height: 16),
                  _buildDropdownField(),
                  const SizedBox(height: 16),
                  _buildTextField("Visiting Purpose", Icons.assignment,
                      (val) => purpose = val!),
                  const SizedBox(height: 16),
                  _buildDatePicker(),
                  const Divider(height: 32),
                  _buildTextField("Flat Number", Icons.home, null,
                      controller: flatNoController),
                  const SizedBox(height: 12),
                  _buildTextField("Block", Icons.location_city, null,
                      controller: blockController),
                  const SizedBox(height: 12),
                  _buildTextField("Floor Number", Icons.stairs, null,
                      controller: floorNoController),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: const Icon(Icons.login),
                      label: const Text("Submit Entry"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9933),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    Function(String?)? onSaved, {
    bool isPhone = false,
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey),
        prefixIcon: Icon(icon, color: const Color(0xFFFF9933)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
        counterText: '',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        if (isPhone && value.length != 10) return 'Phone must be 10 digits';
        return null;
      },
      onSaved: onSaved,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      maxLength: isPhone ? 10 : null,
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Gender",
        labelStyle: TextStyle(color: Colors.blueGrey),
        prefixIcon: const Icon(Icons.wc, color: const Color(0xFFFF9933)),
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
        labelStyle: TextStyle(color: Colors.blueGrey),
        prefixIcon:
            const Icon(Icons.calendar_today, color: const Color(0xFFFF9933)),
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
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Please select today's or a future date"),
              backgroundColor: Colors.red,
            ));
            return;
          }

          visitingDate = DateFormat('yyyy-MM-dd').format(picked);
          _dateController.text = visitingDate;
        }
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select a date' : null,
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ApiRepository apiRepository = ApiRepository();
      _loginModel = LocalStoragePref().getLoginModel();

      FlatIdModel? flatIdData = await apiRepository.getFlatId(
        societyId,
        flatNoController.text,
        blockController.text,
        floorNoController.text,
      );

      if (flatIdData?.status == 200) {
        AddVisitoModel? data = await addVisitorApi(
          flatIdData!.data[0].flatId.toString(),
          societyId,
          requestBy,
          name,
          phone,
          relation,
          gender,
          purpose,
          visitingDate,
        );

        await apiRepository.manualAproveApi(
          data!.uniqueCode.toString(),
          _loginModel!.user!.userId.toString(),
          "entry",
        );

        BlocProvider.of<VisitorsBloc>(context).add(GetEnteredVisitorsEvent());
        Fluttertoast.showToast(msg: "Visitor entry added successfully");
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: flatIdData?.message ?? "Invalid flat details");
      }
    }
  }
}
