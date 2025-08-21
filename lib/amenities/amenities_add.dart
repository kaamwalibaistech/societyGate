import 'package:flutter/material.dart';
import 'package:society_gate/amenities/amenities_images.dart';
import 'package:society_gate/amenities/network/amenities_apis.dart';
import 'package:society_gate/auth/login_success.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/constents/sizedbox.dart';

import '../navigation_screen.dart';

class AmenitiesAdd extends StatefulWidget {
  final String commingFrom;
  const AmenitiesAdd({super.key, this.commingFrom = ""});

  @override
  State<AmenitiesAdd> createState() => _AmenitiesAddState();
}

class _AmenitiesAddState extends State<AmenitiesAdd> {
  List<Map<String, dynamic>> selectedAmenitiesList = [];
  bool? other = false;

  TextEditingController otherAmenitiesName = TextEditingController();
  TextEditingController otherAmenitiesPrice = TextEditingController();
  TextEditingController selectedAmenitiesPrice = TextEditingController();

  String? amenitiesSelectedOption;
  String? selectedAmenitiesDuration;
  String? otherAmenitiesDuration;

  final List<String> amenitiesList = [
    'Swimming Pool',
    'Garden',
    'Parking',
    'Gym',
    'Playground',
    'Club House',
    'Spa',
    'Building Wi-Fi',
    'Rooftop Garden',
  ];
  final List<String> durations = [
    'Monthly',
    '3 Months',
    '6 Months',
    'Yearly',
  ];

  final formKey = GlobalKey<FormState>();
  final _formKeyOtherButton = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF8F9FF),
            Color(0xFFEEF1FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            automaticallyImplyLeading:
                widget.commingFrom == "editAmenities" ? true : false,
            // leading: const Icon(
            //   Icons.arrow_back,
            //   // color: Colors.black,
            // ),
            backgroundColor: Colors.transparent,
            foregroundColor: const Color.fromARGB(221, 27, 27, 27),
            title: const Text("Add Amenities",
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    )),
            centerTitle: true,
            actions: widget.commingFrom == "editAmenities"
                ? null
                : [
                    SizedBox(
                      height: 30,
                      // width: 70,
                      child: OutlinedButton(
                        onPressed: () {
                          LocalStoragePref().setAmenitiesBool(true);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Navigationscreen()));
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          side: const BorderSide(color: Colors.red),
                          backgroundColor: Colors.red.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text(
                          "SKIP",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                    sizedBoxW10(context),
                  ]),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCard(child: _buildAmenityFields()),
                sizedBoxH20(context),
                _buildOtherCheckbox(),
                if (other == true) ...[
                  _buildCard(child: others()),
                ],
                if (selectedAmenitiesList.isNotEmpty) ...[
                  sizedBoxH20(context),
                  _buildAmenitiesChips(),
                ],
                _buildRegisterButton(),
                sizedBoxH30(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white.withOpacity(0.95),
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }

  Widget _buildAmenityFields() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: amenitiesSelectedOption,
          decoration: _inputDecoration("Select Amenity"),
          items: amenitiesList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Row(
                children: [
                  Image.asset(getAmenityImage(value), scale: 2),
                  sizedBoxW10(context),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (newValue) =>
              setState(() => amenitiesSelectedOption = newValue),
          validator: (value) =>
              value == null ? "Please select an amenity" : null,
        ),
        sizedBoxH10(context),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: selectedAmenitiesPrice,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Price (₹)"),
                validator: (value) => value!.isEmpty ? "Enter price" : null,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedAmenitiesDuration,
                decoration: _inputDecoration("Duration"),
                items: durations.map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) =>
                    setState(() => selectedAmenitiesDuration = newValue),
                validator: (value) => value == null ? "Select duration" : null,
              ),
            ),
          ],
        ),
        sizedBoxH10(context),
        ElevatedButton.icon(
          onPressed: _addAmenity,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple.shade100,
            foregroundColor: const Color(0xFF6B4EFF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          ),
          icon: const Icon(Icons.add),
          label: const Text(
            "Add Amenity",
            style: TextStyle(
              // color:
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: other,
          activeColor: Colors.deepPurpleAccent.shade200,
          onChanged: (value) {
            setState(() {
              other = value;
              if (other == false) selectedAmenitiesList.clear();
            });
          },
        ),
        const Text(
          "Add Custom Amenity",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Widget _buildAmenitiesChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: selectedAmenitiesList.asMap().entries.map((entry) {
        final index = entry.key;
        final amenity = entry.value;
        return Chip(
          avatar: Image.asset(getAmenityImage(amenity['name'])),
          backgroundColor: Colors.white,
          label: Text(
            "${amenity['name']} - ₹${amenity['amount']} (${amenity['duration']})",
          ),
          deleteIcon: const Icon(Icons.close, color: Colors.redAccent),
          onDeleted: () {
            setState(() {
              selectedAmenitiesList.removeAt(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${amenity['name']} removed"),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                ),
              );
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildRegisterButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: _registerAmenities,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent.shade200,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          ),
          child: const Text("Register", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  void _addAmenity() {
    if (formKey.currentState!.validate()) {
      setState(() {
        selectedAmenitiesList.add({
          'name': amenitiesSelectedOption,
          'amount': selectedAmenitiesPrice.text,
          'duration': selectedAmenitiesDuration,
        });
        amenitiesSelectedOption = null;
        selectedAmenitiesPrice.clear();
        selectedAmenitiesDuration = null;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Amenity added successfully"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
          ),
        );
      });
    }
  }

  void _registerAmenities() async {
    if (selectedAmenitiesList.isEmpty) {
      // Fluttertoast.showToast(msg: "No amenities added.");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No amenities added."),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: Colors.red,
      ));
      return;
    }

    final loginModel = LocalStoragePref().getLoginModel();
    // ApiRepository apiRepository = ApiRepository();

    final response = await amenitiesSendRawJson(
        selectedAmenitiesList, loginModel?.user?.societyId);

    if (response?["status"] == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response?["message"] ?? "Registered!"}"),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: Colors.green,
      ));

      // Fluttertoast.showToast(msg: response?["message"] ?? "Registered!");
      LocalStoragePref().setAmenitiesBool(true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginSuccess()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response?["message"] ?? "Registration failed!"}"),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: Colors.red,
      ));

      // Fluttertoast.showToast(
      // msg: response?["message"] ?? "Registration failed!");
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }

  Widget others() {
    return Form(
      key: _formKeyOtherButton,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: otherAmenitiesName,
                  decoration: _inputDecoration("Name"),
                  validator: (value) => value!.isEmpty ? "Enter name" : null,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: otherAmenitiesPrice,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration("Price (₹)"),
                  validator: (value) => value!.isEmpty ? "Enter price" : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: otherAmenitiesDuration,
            decoration: _inputDecoration("Duration"),
            items: durations.map((value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
            onChanged: (newValue) =>
                setState(() => otherAmenitiesDuration = newValue),
            validator: (value) => value == null ? "Select duration" : null,
          ),
          otherAddButton(),
        ],
      ),
    );
  }

  Widget otherAddButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          if (_formKeyOtherButton.currentState!.validate()) {
            setState(() {
              selectedAmenitiesList.add({
                'name': otherAmenitiesName.text,
                'amount': otherAmenitiesPrice.text,
                'duration': otherAmenitiesDuration,
              });
              otherAmenitiesName.clear();
              otherAmenitiesPrice.clear();
              otherAmenitiesDuration = null;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Custom amenity added"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                ),
              );
            });
          }
        },
        icon: const Icon(Icons.add),
        label: const Text(
          "Add Custom Amenity",
          style: TextStyle(
            // color: Color(0xFF6B4EFF),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple.shade100,
          foregroundColor: const Color(0xFF6B4EFF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        ),
      ),
    );
  }
}
