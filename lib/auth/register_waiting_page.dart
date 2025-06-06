import 'package:flutter/material.dart';

class ApprovalPendingPage extends StatelessWidget {
  const ApprovalPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("Vaishali Tower B Wing 501"),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.account_circle),
          //     onPressed: () {},
          //   ),
          // ],
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Your account needs approval from Our Company or Management Committee to ensure that only verified residents get access to SocietyGate.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          // Timeline and FAQ
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text("Application submitted to Verification"),
                  subtitle: Text(
                      "We've Received your request of Registeration of Your society."),
                ),
                ListTile(
                  leading:
                      Icon(Icons.notifications_active, color: Colors.orange),
                  title: Text("We’re reminding"),
                  subtitle: Text("We send reminders every 24 Hours"),
                ),
                ListTile(
                  leading: Icon(Icons.hourglass_empty, color: Colors.grey),
                  title: Text("Verification by our Management Committee"),
                  subtitle: Text("Most approvals happen within 72 hours."),
                ),
                Divider(),
                Center(
                    child: Text("FAQ",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                ExpansionTile(
                  title: Text(
                      "My approval is pending for more than 72 hours, What can I do?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "For faster approvals, we suggest reaching out to our support center to see if there is any other pending action.",
                      ),
                    ),
                  ],
                ),
                // ExpansionTile(
                //   title: Text("No one is approving. Can SocietyGate help?"),
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 12.0),
                //       child: Text(
                //         "Unfortunately, we do not have the authority to approve your request directly. Please reach out to your society office/management committee for faster approvals.",
                //       ),
                //     ),
                //   ],
                // ),

                ExpansionTile(
                  title: Text("Can I edit my details after submission?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "No, once submitted you cannot edit your registration details. Please contact your society admin for any corrections.",
                      ),
                    ),
                  ],
                ),

                ExpansionTile(
                  title: Text("How will I know when my account is approved?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "You will receive a notification and email once your account has been approved by our Management Committee.",
                      ),
                    ),
                  ],
                ),

                // ExpansionTile(
                //   title: Text("Why is my request taking so long?"),
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 12.0),
                //       child: Text(
                //         "Approvals are handled by your society admin or management committee. Delays can occur due to holidays, non-working hours, or internal verifications.",
                //       ),
                //     ),
                //   ],
                // ),

                ExpansionTile(
                  title: Text("Who approves my request?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Your request is reviewed and approved by our management committee.",
                      ),
                    ),
                  ],
                ),

                ExpansionTile(
                  title: Text("Can I access app features before approval?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Access is restricted until your account is approved. You will gain full access once verification is completed.",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
