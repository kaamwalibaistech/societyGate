import 'package:flutter/material.dart';
import 'package:my_society/constents/sizedbox.dart';

class RegisterMember extends StatefulWidget {
  const RegisterMember({super.key});

  @override
  State<RegisterMember> createState() => _RegisterMemberState();
}

class _RegisterMemberState extends State<RegisterMember> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f3fa),
      appBar: AppBar(
        backgroundColor: const Color(0xfff0f3fa),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align content
              children: [
                const Center(
                  child: Text(
                    "Create a member account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {}, // Add login navigation
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                sizedBoxH20(context),
                inputFeild(
                    "Name", "Enter your name", nameController, null, null),
                inputFeild("Phone", "Enter your phone number", phoneController,
                    phoneValidator, TextInputType.number),
                inputFeild("Email", "Enter your email", emailController,
                    emailValidator, TextInputType.emailAddress),
                inputFeild("Password", "Enter password", passwordController,
                    passwordValidator, TextInputType.visiblePassword,
                    isPassword: true),
                inputFeild(
                    "Confirm Password",
                    "Re-enter password",
                    confirmPasswordController,
                    confirmPasswordValidator,
                    TextInputType.visiblePassword,
                    isPassword: true),
                Row(
                  children: [
                    Checkbox(
                        value: !isPasswordHidden,
                        onChanged: (value) {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        }),
                    const Text("Show password")
                  ],
                ),
                sizedBoxH20(context),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // All validations passed
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Registration Successful")),
                        );
                      }
                    },
                    child: const Text("Register"),
                  ),
                ),
                sizedBoxH20(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputFeild(
    String title,
    String? hintText,
    TextEditingController controller,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType, {
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        sizedBoxH5(context),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            keyboardType: keyboardType,
            maxLength: title == "Phone" ? 10 : 50,
            controller: controller,
            validator: validator,
            obscureText: isPassword ? isPasswordHidden : false,
            decoration: InputDecoration(
              fillColor: Colors.white,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              counterText: "",
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        sizedBoxH10(context),
      ],
    );
  }

  // Validators
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    if (value.length != 10) {
      return "Phone number must be 10 digits";
    }
    return null;
  }
}
