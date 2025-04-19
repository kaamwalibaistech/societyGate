import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:society_gate/api/api_repository.dart';
import 'package:society_gate/constents/local_storage.dart';
import 'package:society_gate/constents/sizedbox.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Help & Support",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF2D3142),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How can we help you?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "We're here to assist you. Please describe your issue or suggestion in detail.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6C7A9C),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Issue Type",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3142),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: TextFormField(
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2D3142),
                  ),
                  decoration: const InputDecoration(
                    hintText: "Enter the type of issue",
                    hintStyle: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 16,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3142),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: TextFormField(
                  controller: messageController,
                  maxLines: 10,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2D3142),
                  ),
                  decoration: const InputDecoration(
                    hintText: "Please describe your issue in detail",
                    hintStyle: TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 16,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () async {
                  if (titleController.text.isNotEmpty &&
                      messageController.text.isNotEmpty) {
                    final loginModel = LocalStoragePref().getLoginModel();
                    ApiRepository apiRepository = ApiRepository();
                    final data = await apiRepository.postSupportMessage(
                        loginModel!.user!.societyId.toString(),
                        loginModel.user!.userId.toString(),
                        titleController.text,
                        messageController.text);
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: data!.message.toString());
                  } else {
                    Fluttertoast.showToast(msg: "Both fields are required");
                  }
                },
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2196F3),
                        Color(0xFF1976D2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2196F3).withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.support_agent_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Submit Request",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
