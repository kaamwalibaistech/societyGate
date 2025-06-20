import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/auth/network/login_api.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/models/login_model.dart';
import 'package:society_gate/models/update_user_model.dart';

class ProfileScreen extends StatefulWidget {
  final String? namee;
  final String? phoneNumber;
  final String? email;
  const ProfileScreen(
      {super.key,
      required this.namee,
      required this.phoneNumber,
      required this.email});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController emailAddressController;

  final _formKey = GlobalKey<FormState>();
  String? userPhoto;
  UpdateUserModel? userData;
  LoginModel? logInData;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.namee);
    phoneController = TextEditingController(text: widget.phoneNumber);
    emailAddressController = TextEditingController(text: widget.email);
    getLogInModel();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailAddressController.dispose();
    super.dispose();
  }

  void getLogInModel() {
    logInData = LocalStoragePref().getLoginModel();
  }

  File? imagee;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          imagee = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected.')),
        );
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
      print('PlatformException: ${e.code} - ${e.message}');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred.')),
      );
      print('Unexpected error: $e');
    }
  }

  void showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Image Source",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF0F7FF),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  showImagePickerOptions();
                },
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
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
                          child: imagee == null
                              ? logInData?.user?.profileImage != null
                                  ? ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            logInData!.user!.profileImage!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(imagee!))
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(imagee!))),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 70.0, top: 80),
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
                controller: fullNameController,
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
                controller: phoneController,
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
                controller: emailAddressController,
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
                  if (_formKey.currentState!.validate()) {
                    passwordDialog(
                      fullNameController.text,
                      emailAddressController.text,
                      phoneController.text,
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
          // keyboardType: keyboardType,
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
            fillColor: const Color.fromARGB(255, 234, 242, 255),
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
    bool isPasswordVisible = false; // 👈 local variable

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // 👈 use this to manage dialog's local state
          builder: (context, setState) {
            return AlertDialog(
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
                    obscureText: !isPasswordVisible,
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
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
                      final loginData = await login(
                          logInData!.user!.uphone.toString(),
                          passwordController.text);

                      if (loginData!.status == 200) {
                        ApiRepository apiRepository = ApiRepository();
                        userData = await apiRepository.updateUser(
                            logInData?.user?.userId.toString(),
                            name,
                            email,
                            phone,
                            imagee?.path);
                        await LocalStoragePref().storeLoginModel(loginData);

                        Fluttertoast.showToast(
                            msg: userData?.message.toString() ?? "");

                        Navigator.pop(context); // close dialog
                        Navigator.pop(context); // go back
                      } else {
                        Fluttertoast.showToast(msg: "Password is Incorrect");
                      }
                    } else {
                      Fluttertoast.showToast(msg: "Please Enter Password");
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
            );
          },
        );
      },
    );
  }
}
