import 'package:flutter/material.dart';

class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({super.key});

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accHolderCtrl = TextEditingController();
  final TextEditingController _bankNameCtrl = TextEditingController();
  final TextEditingController _accNumberCtrl = TextEditingController();
  final TextEditingController _confirmAccCtrl = TextEditingController();
  final TextEditingController _ifscCtrl = TextEditingController();
  final TextEditingController _panCtrl = TextEditingController();
  final TextEditingController _gstCtrl = TextEditingController();

  void _submitBankDetails() {
    if (_formKey.currentState!.validate()) {
      // Send details to backend or Razorpay route creation logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Submitting bank details...")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Bank Details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTextField(
                        label: "Account Holder Name",
                        controller: _accHolderCtrl,
                        validatorMsg: "Enter account holder name"),
                    _buildTextField(
                        label: "Bank Name",
                        controller: _bankNameCtrl,
                        validatorMsg: "Enter bank name"),
                    _buildTextField(
                        label: "Account Number",
                        controller: _accNumberCtrl,
                        keyboardType: TextInputType.number,
                        validatorMsg: "Enter account number"),
                    _buildTextField(
                        label: "Confirm Account Number",
                        controller: _confirmAccCtrl,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != _accNumberCtrl.text) {
                            return "Account numbers do not match";
                          }
                          return null;
                        }),
                    _buildTextField(
                        label: "IFSC Code",
                        controller: _ifscCtrl,
                        textCapitalization: TextCapitalization.characters,
                        validatorMsg: "Enter IFSC code"),
                    _buildTextField(
                      label: "PAN Number (Optional)",
                      controller: _panCtrl,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    _buildTextField(
                      label: "GSTIN (Optional)",
                      controller: _gstCtrl,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _submitBankDetails,
                      icon: const Icon(Icons.save),
                      label: const Text("Submit & Save"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? validatorMsg,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator ??
            (validatorMsg != null
                ? (value) {
                    if (value == null || value.isEmpty) return validatorMsg;
                    return null;
                  }
                : null),
      ),
    );
  }
}
