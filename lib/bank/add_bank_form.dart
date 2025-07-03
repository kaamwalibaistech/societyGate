import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:society_gate/api/api_constant.dart';
import 'package:society_gate/models/login_model.dart';

class AddBankDetailsPage extends StatefulWidget {
  final LoginModel? loginModel;
  const AddBankDetailsPage({super.key, required this.loginModel});

  @override
  State<AddBankDetailsPage> createState() => _AddBankDetailsPageState();
}

class _AddBankDetailsPageState extends State<AddBankDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  //type = route
  final TextEditingController refId = TextEditingController();
  final TextEditingController businessName = TextEditingController();
  // "business_type":"partnership",
  final TextEditingController contactName = TextEditingController();
  final TextEditingController pan = TextEditingController();
  final TextEditingController gst = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController subcategory = TextEditingController();

  // Address
  final TextEditingController street1 = TextEditingController();
  final TextEditingController street2 = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  final TextEditingController country = TextEditingController(text: 'IN');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Bank Details"),
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Business Info",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                  controller: contactName,
                  decoration: const InputDecoration(labelText: "Owner Name")),
              TextFormField(
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Required";
                    } else {
                      return null;
                    }
                  },
                  controller: email,
                  decoration: const InputDecoration(labelText: "Email")),
              TextFormField(
                  controller: phone,
                  decoration: const InputDecoration(labelText: "Phone")),
              TextFormField(
                  controller: refId,
                  decoration: const InputDecoration(labelText: "Reference ID")),
              TextFormField(
                  controller: businessName,
                  decoration:
                      const InputDecoration(labelText: "Legal Business Name")),
              TextFormField(
                  controller: category,
                  decoration: const InputDecoration(labelText: "category")),
              TextFormField(
                  controller: subcategory,
                  decoration: const InputDecoration(labelText: "subcategory")),
              const SizedBox(height: 20),
              const Text("Legal Info",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                  controller: pan,
                  decoration: const InputDecoration(labelText: "PAN Number")),
              TextFormField(
                  controller: gst,
                  decoration: const InputDecoration(labelText: "GST Number")),
              const SizedBox(height: 20),
              const Text("Registered Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                  controller: street1,
                  decoration: const InputDecoration(labelText: "Street 1")),
              TextFormField(
                  controller: street2,
                  decoration: const InputDecoration(labelText: "Street 2")),
              TextFormField(
                  controller: city,
                  decoration: const InputDecoration(labelText: "City")),
              TextFormField(
                  controller: state,
                  decoration: const InputDecoration(labelText: "State")),
              TextFormField(
                  controller: postalCode,
                  decoration: const InputDecoration(labelText: "Postal Code")),
              TextFormField(
                  controller: country,
                  decoration: const InputDecoration(labelText: "Country")),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createRouteAccount();
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createRouteAccount() async {
    final body = {
      "email": email.text,
      "phone": phone.text,
      "type": "route",
      "reference_id": refId.text,
      "legal_business_name": businessName.text,
      "business_type": "partnership",
      // "business_type": "unregistered",
      "contact_name": contactName.text,
      "profile": {
        "category": category.text,
        "subcategory": subcategory.text,
        "addresses": {
          "registered": {
            "street1": street1.text,
            "street2": street2.text,
            "city": city.text,
            "state": state.text,
            "postal_code": postalCode.text,
            "country": country.text
          }
        }
      },
      "legal_info": {"pan": pan.text, "gst": gst.text}
    };

    try {
      const username = "rzp_test_Kc0D3gsG5D09RJ"; //  Razorpay Key ID
      const password = "LcCmBfKtlajuiR9H2ruqRubl"; // Razorpay Key Secret
      final credentials = base64Encode(utf8.encode("$username:$password"));

      final response = await http.post(
        Uri.parse("https://api.razorpay.com/v2/accounts"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic $credentials"
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created successfully")),
        );
        // await storeAccId( widget.loginModel?.user?.societyId.toString() ?? "", "");
        log(data);
      } else {
        log(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.body}")),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> storeAccId(
    String societyId,
    String accId,
  ) async {
    String api = ApiConstant.storeAccId;
    String baseUrl = ApiConstant.baseUrl;
    Uri url = Uri.parse(baseUrl + api);

    final body = {
      'society_id': societyId,
      'razorpay_account_id': accId,
    };
    try {
      final response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // if (data['status'] == 200) {
        // return LoginModel.fromJson(data);
        // }
      }
    } catch (e) {
      throw Exception();
    }
  }
}
