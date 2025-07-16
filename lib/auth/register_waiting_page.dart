import 'package:flutter/material.dart';
import 'package:society_gate/constents/sizedbox.dart';

class ApprovalPendingPage extends StatelessWidget {
  const ApprovalPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Approval Pending"),
        backgroundColor: Colors.orange.shade300,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Orange header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.orange.shade300,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Approval Pending",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Your account needs approval from our team to ensure that only verified residents get access to SocietyGate.",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),

          // Timeline and FAQ
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildTimelineTile(
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                  title: "Application submitted",
                  subtitle:
                      "We've received your request for society registration.",
                ),
                _buildTimelineTile(
                  icon: Icons.notifications_active,
                  iconColor: Colors.orange,
                  title: "We’re reminding",
                  subtitle: "We send reminders every 24 hours.",
                ),
                _buildTimelineTile(
                  icon: Icons.hourglass_empty,
                  iconColor: Colors.grey,
                  title: "Verification by Management Committee",
                  subtitle: "Most approvals happen within 72 hours.",
                ),
                const Divider(height: 32, color: Colors.grey),
                Center(
                  child: Text(
                    "FAQs",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800),
                  ),
                ),
                const SizedBox(height: 8),
                _buildFAQTile(
                  title:
                      "My approval is pending for more than 72 hours, what can I do?",
                  content:
                      "For faster approvals, we suggest reaching out to our support center to see if there is any other pending action.",
                ),
                _buildFAQTile(
                  title: "Can I edit my details after submission?",
                  content:
                      "No, once submitted you cannot edit your registration details. Please contact your society admin for any corrections.",
                ),
                _buildFAQTile(
                  title: "How will I know when my account is approved?",
                  content:
                      "You will receive a notification and email once your account has been approved by our Management Committee.",
                ),
                _buildFAQTile(
                  title: "Who approves my request?",
                  content:
                      "Your request is reviewed and approved by our management committee.",
                ),
                _buildFAQTile(
                  title: "Can I access app features before approval?",
                  content:
                      "Access is restricted until your account is approved. You will gain full access once verification is completed.",
                ),
                sizedBoxH30(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildFAQTile({
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.orange.shade50,
            collapsedBackgroundColor: Colors.grey.shade100,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            children: [
              Text(
                content,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
