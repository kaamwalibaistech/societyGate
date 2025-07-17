import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  final TextEditingController refId = TextEditingController();
  final TextEditingController businessName = TextEditingController();
  final TextEditingController contactName = TextEditingController();
  final TextEditingController pan = TextEditingController();
  final TextEditingController gst = TextEditingController();
  final TextEditingController street1 = TextEditingController();
  final TextEditingController street2 = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  final TextEditingController country = TextEditingController(text: 'IN');

  @override
  void dispose() {
    email.dispose();
    phone.dispose();
    refId.dispose();
    businessName.dispose();
    contactName.dispose();
    pan.dispose();
    gst.dispose();
    street1.dispose();
    street2.dispose();
    city.dispose();
    state.dispose();
    postalCode.dispose();
    country.dispose();
    super.dispose();
  }

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
              sectionTitle("Society Information"),
              formField("Secretary Name", contactName),
              formField("Email", email, required: true, isEmail: true),
              formField("Phone", phone, required: true),
              formField("Legal Society Name", businessName),
              sectionTitle("Legal Info"),
              formField("PAN Number", pan),
              formField("GST Number", gst),
              sectionTitle("Registered Address"),
              formField("Street 1", street1),
              formField("Street 2", street2),
              formField("City", city),
              formField("State", state),
              formField("Postal Code", postalCode),
              formField("Country", country),
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

  Widget sectionTitle(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
        ],
      );

  Widget formField(String label, TextEditingController controller,
      {bool required = true, bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (required && (value == null || value.trim().isEmpty)) {
          return "Required";
        }
        if (isEmail && !RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
          return "Enter valid email";
        }
        return null;
      },
    );
  }

  Future<void> createRouteAccount() async {
    EasyLoading.show(status: 'Submitting...');
    final body = {
      "email": email.text,
      "phone": phone.text,
      "type": "route",
      "reference_id": "SID${widget.loginModel?.user?.societyId}1",
      "legal_business_name": businessName.text,
      "business_type": "partnership",
      "contact_name": contactName.text,
      "profile": {
        "category": "housing",
        "subcategory": "facility_management",
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
      const username = "rzp_test_Kc0D3gsG5D09RJ";
      const password = "LcCmBfKtlajuiR9H2ruqRubl";
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
        log("Account Created: $data");
        String accId = data['id'] ?? "";

        await storeAccId(
            widget.loginModel?.user?.societyId.toString() ?? "", accId);

        EasyLoading.dismiss();
        EasyLoading.showSuccess("Account created successfully");
        Navigator.pop(context);
      } else {
        log("Failed: ${response.body}");
        EasyLoading.dismiss();
        EasyLoading.showError(
            "Error: ${jsonDecode(response.body)['error']['description'] ?? 'Failed'}");
      }
    } catch (e) {
      log("Exception: $e");
      EasyLoading.dismiss();
      EasyLoading.showError("Something went wrong");
    }
  }

  Future<void> storeAccId(String societyId, String accId) async {
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
        log("Acc ID Stored: $data");
      } else {
        log("StoreAccId Failed: ${response.body}");
      }
    } catch (e) {
      log("StoreAccId Exception: $e");
    }
  }
}
