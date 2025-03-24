import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_society/constents/local_storage.dart';
import 'package:my_society/dashboard/visitors/network/edit_visitor.dart';
import 'package:my_society/dashboard/visitors/visitors_bloc/visitors_bloc.dart';
import 'package:my_society/models/visitors_details_model.dart';

import '../../models/login_model.dart';
import 'visitor_view_bloc/visitors_view_bloc.dart';
import 'visitor_view_bloc/visitors_view_event.dart';

class EditVisitor extends StatefulWidget {
  final VisitorsDetailModel? visitorsDetailModel;
  const EditVisitor({super.key, required this.visitorsDetailModel});

  @override
  State<EditVisitor> createState() => _EditVisitorState();
}

class _EditVisitorState extends State<EditVisitor> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dateController;
  late String flatId, societyId, requestBy;
  late String name, phone, relation, gender, purpose, visitingDate;
  LoginModel? _loginModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  getInitialData() {
    _loginModel = LocalStoragePref().getLoginModel();
    setState(() {
      gender = widget.visitorsDetailModel!.data!.gender.toString();
      visitingDate = widget.visitorsDetailModel!.data!.visitingDate.toString();
      _dateController = TextEditingController(
          text: widget.visitorsDetailModel!.data!.visitingDate.toString());
    });
    if (_loginModel != null) {
      setState(() {
        flatId = _loginModel!.user!.flatId.toString();
        societyId = _loginModel!.user!.societyId.toString();
        requestBy = _loginModel!.user!.userId.toString();
      });
    }
  }

  void apiCall() async {
    isLoading = true;
    try {
      String? message = await editVisitorApi(
          flatId,
          name,
          phone,
          relation,
          gender,
          purpose,
          visitingDate,
          requestBy,
          societyId,
          widget.visitorsDetailModel!.data!.visitorId.toString());

      Fluttertoast.showToast(msg: message ?? "Error");
      await Future.delayed(Duration(microseconds: 1000));
      if (mounted) {
        context.read<VisitorsDetailBloc>().add(GetVisitorDetailEvent(
            visitorId: widget.visitorsDetailModel!.data!.visitorId.toString()));
        context.read<VisitorsBloc>().add(GetVisitorsEvent(
            soceityId: societyId.toString(), flatId: flatId.toString()));
        Navigator.pop(context);
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      throw Exception(e);
    }
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Visitor"),
        centerTitle: true,
        backgroundColor: Colors.purple.shade100,
      ),
      body: Stack(alignment: Alignment.center, children: [
        Padding(
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
                    hint: Text(
                        widget.visitorsDetailModel!.data!.gender.toString()),
                    decoration: const InputDecoration(
                      labelText: "Gender",
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     setState(() {
                    //       gender =
                    //           widget.visitorsDetailModel!.data!.gender.toString();
                    //     });
                    //     return null;
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    items: ["male", "female", "other"].map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) => gender = val!,
                  ),
                  _buildTextField(
                      "Visiting Purpose",
                      (val) => purpose = val!,
                      TextEditingController(
                          text: widget
                              .visitorsDetailModel!.data!.visitingPurpose)),
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
                          visitingDate =
                              DateFormat('yyyy-MM-dd').format(picked);
                          _dateController.text = visitingDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // method api call
                        apiCall();
                      }
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black26,
          ),
        ),
        Visibility(visible: isLoading, child: CircularProgressIndicator())
      ]),
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
        if (value == null || value.isEmpty) {
          value = controller.text;
          return 'required';
        }
        if (isPhone && value.length != 10) return 'Phone must be 10 digits';
        return null;
      },
      onSaved: onSaved,
      keyboardType: isPhone ? TextInputType.number : TextInputType.text,
      maxLength: isPhone ? 10 : null,
    );
  }
}
