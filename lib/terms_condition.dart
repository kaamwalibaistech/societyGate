import 'package:flutter/material.dart';

class TermsConditionScreen extends StatefulWidget {
  const TermsConditionScreen({super.key});

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Terms & Conditions",
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
                      "Welcome to Society Gate",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "These Terms and Conditions govern your access to and use of The Society Gate mobile application. Please read them carefully.",
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
              _buildSection(
                title: "1. Eligibility",
                content: [
                  "To use the App, you must:",
                  "• Be at least 18 years of age",
                  "• Have the legal capacity to enter into a binding agreement",
                  "• Use the App in accordance with all applicable local, state, and central laws and regulations",
                ],
              ),
              _buildSection(
                title: "2. Scope of Services",
                content: [
                  "The Society Gate App is designed to streamline the operations of residential societies and provides distinct functionalities to three user roles:",
                  "2.1 Admin Users",
                  "• Send notices and announcements",
                  "• Generate and send visitor passes",
                  "• Manage rent agreements and shop listings",
                  "• Access and use the internal chat system",
                  "2.2 Society Members",
                  "• View notices and announcements",
                  "• Book society amenities",
                  "• Pay maintenance bills via secure payment gateway",
                  "• Generate visitor gate passes",
                  "• Add family members to the App",
                  "• Communicate with admins and watchmen via chat",
                  "2.3 Watchmen",
                  "• View the member list for verification",
                  "• Approve and manage visitor entries",
                  "• Use the chat feature for communication",
                ],
              ),
              _buildSection(
                title: "3. User Obligations",
                content: [
                  "As a condition of use, all users agree:",
                  "• Not to impersonate another individual",
                  "• Not to upload or share unlawful content",
                  "• Not to reverse-engineer or modify the App",
                  "• Not to misuse communication features",
                  "• To comply with all applicable privacy laws",
                ],
              ),
              _buildSection(
                title: "4. Account Security",
                content: [
                  "• Users must provide accurate information during registration",
                  "• Users are responsible for maintaining login credentials",
                  "• Notify us immediately of any unauthorized account use",
                ],
              ),
              _buildSection(
                title: "5. Payments",
                content: [
                  "• Maintenance bill payments via third-party gateways",
                  "• No storage of sensitive payment data",
                  "• Subject to third-party payment service terms",
                ],
              ),
              _buildSection(
                title: "6. Privacy",
                content: [
                  "• Limited license for personal use",
                  "• Intellectual property belongs to The Society Gate",
                  "• No unauthorized use of intellectual property",
                ],
              ),
              _buildSection(
                title: "7. Contact",
                content: [
                  "For any concerns or questions:",
                  "Email: support@societygate.com",
                  "Phone: +91 1234567890",
                  "Website: www.societygate.com",
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "By using The Society Gate's services, you acknowledge that you have read, understood, and agree to these Terms and Conditions.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6C7A9C),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<String> content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
        ),
        const SizedBox(height: 12),
        ...content.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6C7A9C),
                  height: 1.5,
                ),
              ),
            )),
        const SizedBox(height: 24),
      ],
    );
  }
}
