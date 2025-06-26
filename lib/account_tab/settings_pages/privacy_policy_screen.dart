import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Privacy Policy",
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
                      "Your Privacy Matters",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "At The Society Gate, we value your privacy and are committed to protecting your personal information. This policy explains how we collect, use, and protect your data.",
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
                title: "1. Information We Collect",
                content: [
                  "To provide and improve our services, we collect:",
                  "• Personal details (name, address, phone, email)",
                  "• Device location for services like amenity booking",
                  "• Camera/gallery access for document uploads",
                  "• Usage data to enhance functionality",
                  "• Chat interaction data for communication",
                ],
              ),
              _buildSection(
                title: "2. Types of Users",
                content: [
                  "The App serves three user types:",
                  "2.1 Admin Users",
                  "• Register new users and manage data",
                  "• Send notices and generate visitor passes",
                  "• Manage rent agreements and shop listings",
                  "• Access internal chat system",
                  "2.2 Society Members",
                  "• View notices and book amenities",
                  "• Pay maintenance bills securely",
                  "• Generate visitor passes",
                  "• Add family members",
                  "• Chat with other members",
                  "2.3 Watchmen",
                  "• Manage visitor details",
                  "• Access member list",
                  "• Use chat feature",
                ],
              ),
              _buildSection(
                title: "3. How We Use Your Information",
                content: [
                  "We use your data to:",
                  "• Provide access to app features",
                  "• Enhance app performance",
                  "• Send notices and updates",
                  "• Process payments securely",
                  "• Protect app security",
                ],
              ),
              _buildSection(
                title: "4. Data Security",
                content: [
                  "We implement measures to protect your data:",
                  "• Secure data transmission",
                  "• Regular security updates",
                  "• Access controls",
                  "• Data encryption",
                ],
              ),
              _buildSection(
                title: "5. Your Rights",
                content: [
                  "Under Indian law, you have rights to:",
                  "• Access your personal data",
                  "• Request corrections",
                  "• Delete your account",
                  "• Withdraw consent",
                  "• Object to data processing",
                ],
              ),
              _buildSection(
                title: "6. Contact Us",
                content: [
                  "For privacy concerns:",
                  "Email: privacy@societygate.com",
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
                  "By using The Society Gate App, you agree to the collection and use of your personal information in accordance with this Privacy Policy.",
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
