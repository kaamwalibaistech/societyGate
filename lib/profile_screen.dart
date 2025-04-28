import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/auth/login_bloc/login_bloc.dart';
import 'package:society_gate/constents/local_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F7FF),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF4A90E2),
        elevation: 0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF4A90E2),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4A90E2).withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 60,
                          backgroundColor: Color(0xFFE3F2FD),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Color(0xFF4A90E2),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A90E2),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4A90E2).withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  label: "Full Name",
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  hintText: "Enter your full name",
                  prefixIcon: Icons.person_outline_rounded,
                  iconColor: const Color(0xFF4CAF50),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: "Phone Number",
                  controller: phoneNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone number";
                    }
                    if (value.length != 10) {
                      return "Please enter a valid 10-digit phone number";
                    }
                    return null;
                  },
                  hintText: "[xxx] xx xxxxxx",
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  iconColor: const Color(0xFF2196F3),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: "Email Address",
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!value.contains('@')) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  hintText: "example@gmail.com",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  iconColor: const Color(0xFF9C27B0),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      passwordDialog(
                        nameController.text,
                        emailController.text,
                        phoneNumberController.text,
                      );
                    }
                  },
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF4A90E2),
                          Color(0xFF2196F3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4A90E2).withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Update Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required String hintText,
    required IconData prefixIcon,
    Color? iconColor,
    TextInputType? keyboardType,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2D3142),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLength: maxLength,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF2D3142),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF9E9E9E),
              fontSize: 16,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: iconColor ?? const Color(0xFF4A90E2),
            ),
            filled: true,
            fillColor: const Color(0xFFF5F9FF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            counterText: "",
          ),
        ),
      ],
    );
  }

  void passwordDialog(String name, String email, String phone) {
    TextEditingController passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          "Confirm Update",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please enter your current password to confirm the changes:",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6C7A9C),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF2D3142),
              ),
              decoration: InputDecoration(
                hintText: "Enter your password",
                hintStyle: const TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 16,
                ),
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: Color(0xFF4A90E2),
                ),
                filled: true,
                fillColor: const Color(0xFFF5F9FF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Color(0xFF6C7A9C),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (passwordController.text.isNotEmpty) {
                ApiRepository apiRepository = ApiRepository();
                final data = LocalStoragePref.instance!.getLoginModel();

                final dataa = await apiRepository.updateUser(
                  data!.user!.userId.toString(),
                  name,
                  email,
                  phone,
                );
                Navigator.pop(context);
                Navigator.pop(context);
                Fluttertoast.showToast(msg: dataa!.message.toString());

                BlocProvider.of<LoginBloc>(context).add(
                  LoginButtonEvent(phone, passwordController.text),
                );
              }
            },
            child: const Text(
              "Confirm",
              style: TextStyle(
                color: Color(0xFF4A90E2),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
