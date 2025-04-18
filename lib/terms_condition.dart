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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  textAlign: TextAlign.justify,
                  "These Terms and Conditions (Terms) govern your access to and use of The Society Gate mobile application ('App' or 'Application') developed to facilitate subscription-based society management services. The App is owned and operated by The Society Gate, herein referred to as 'Company', 'we', 'us', or 'our'. These Terms form a legally binding agreement between you ('User', 'your') and The Society Gate regarding your use of the App."),
              SizedBox(
                height: 5,
              ),
              Text(
                  textAlign: TextAlign.justify,
                  "By downloading, accessing, or using the App, you acknowledge that you have read, understood, and agree to be bound by these Terms. If you do not agree to these Terms, do not access or use the App."),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "1. Eligibility",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "To use the App, you must:",
                style: TextStyle(),
              ),
              Text(
                "Be at least 18 years of age;",
                style: TextStyle(),
              ),
              Text(
                "Have the legal capacity to enter into a binding agreement;",
                style: TextStyle(),
              ),
              Text(
                "Use the App in accordance with all applicable local, state, and central laws and regulations.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "2. Scope of Services",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "The Society Gate App is designed to streamline the operations of residential societies and provides distinct functionalities to three user roles:",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "2.1 Admin Users",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                textAlign: TextAlign.justify,
                "•	Admins are responsible for managing the society’s data and functionalities. They can:",
                style: TextStyle(),
              ),
              Text(
                "•	Send notices and announcements.",
                style: TextStyle(),
              ),
              Text(
                "•  Generate and send visitor passes.",
                style: TextStyle(),
              ),
              Text(
                "•	Manage rent agreements and shop listings.",
                style: TextStyle(),
              ),
              Text(
                "•	Access and use the internal chat system.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "2.2 Society Members",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Members are residents of the society who can:",
                style: TextStyle(),
              ),
              Text(
                "•	View notices and announcements.",
                style: TextStyle(),
              ),
              Text(
                "•	Book society amenities.",
                style: TextStyle(),
              ),
              Text(
                "•	Pay maintenance bills via a secure third-party payment gateway.s",
                style: TextStyle(),
              ),
              Text(
                "•	Generate visitor gate passes.",
                style: TextStyle(),
              ),
              Text(
                "•	Add family members to the App.",
                style: TextStyle(),
              ),
              Text(
                "•	Communicate with admins and watchmen via chat",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "2.3 Watchmen",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Watchmen or security personnel are given limited access to:",
                style: TextStyle(),
              ),
              Text(
                "•	View the member list for verification.",
                style: TextStyle(),
              ),
              Text(
                "•	Approve and manage visitor entries.",
                style: TextStyle(),
              ),
              Text(
                "•	Use the chat feature for communication.",
                style: TextStyle(),
              ),
              Text(
                "•	Each user is accountable for the use of their login credentials and should maintain the confidentiality and security of their account.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "3. User Obligations and Responsibilities",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "As a condition of use, all users agree:",
                style: TextStyle(),
              ),
              Text(
                "•	Not to impersonate another individual or provide false identity information.",
                style: TextStyle(),
              ),
              Text(
                "•	Not to upload or share unlawful, harmful, defamatory, or obscene content.",
                style: TextStyle(),
              ),
              Text(
                "•	Not to reverse-engineer, modify, or tamper with the App.",
                style: TextStyle(),
              ),
              Text(
                "•	Not to misuse communication features (e.g., chat) to harass or threaten others.",
                style: TextStyle(),
              ),
              Text(
                "•	To comply with all applicable privacy, data protection, and cybersecurity laws.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "4. Account Registration and Security",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Users must provide accurate and complete information during account creation.",
                style: TextStyle(),
              ),
              Text(
                "Users are responsible for maintaining the confidentiality of login credentials",
                style: TextStyle(),
              ),
              Text(
                "You agree to notify us immediately of any unauthorized use of your account.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "5. Payments and Transactions",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Maintenance bill payments are made via third-party payment gateways integrated into the App.",
                style: TextStyle(),
              ),
              Text(
                "The Company does not collect or store sensitive payment data (such as credit/debit card numbers).",
                style: TextStyle(),
              ),
              Text(
                "Users are subject to the terms and conditions of the respective third-party payment services.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "6. Data Collection and Privacy",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "The Company grants you a limited, non-transferable, non-sublicensable, revocable license to use the App solely for personal and lawful purposes.",
                style: TextStyle(),
              ),
              Text(
                "All intellectual property, including trademarks, logos, software, graphics, and content, is the exclusive property of The Society Gate.",
                style: TextStyle(),
              ),
              Text(
                "You may not use any of our intellectual property without our prior written consent.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "7. License and Intellectual Property",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "The Company grants you a limited, non-transferable, non-sublicensable, revocable license to use the App solely for personal and lawful purposes.",
                style: TextStyle(),
              ),
              Text(
                "All intellectual property, including trademarks, logos, software, graphics, and content, is the exclusive property of The Society Gate.",
                style: TextStyle(),
              ),
              Text(
                "You may not use any of our intellectual property without our prior written consent.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "8. User-Generated Content",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "If you upload or submit any content (e.g., images of visitors or documents):",
                style: TextStyle(),
              ),
              Text(
                "You grant The Society Gate a non-exclusive, royalty-free, worldwide license to use, display, and store that content solely for service delivery.",
                style: TextStyle(),
              ),
              Text(
                "You warrant that you have the necessary rights to provide such content.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "9. Communications and Notifications",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "The App uses in-app messaging and notifications to communicate important updates.",
                style: TextStyle(),
              ),
              Text(
                "Users consent to receive notices, transaction confirmations, and administrative messages via email, SMS, or app notifications.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "10. Third-Party Services and Links",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "The App may contain links or integrations with third-party websites or services (e.g., payment gateways).",
                style: TextStyle(),
              ),
              Text(
                "The Company is not responsible for the availability, content, or policies of such third-party services.",
                style: TextStyle(),
              ),
              Text(
                "Use of these services is governed by their respective terms and privacy policies.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "11. Termination of Access",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "We reserve the right to suspend or terminate your account or access to the App, with or without notice, for:",
                style: TextStyle(),
              ),
              Text(
                "•	Breach of these Terms.",
                style: TextStyle(),
              ),
              Text(
                "•	Violation of applicable laws.",
                style: TextStyle(),
              ),
              Text(
                "•	Activities that harm or compromise the integrity, performance, or security of the App.",
                style: TextStyle(),
              ),
              Text(
                "•	Users may also terminate their account by contacting support with a deletion request, subject to data retention obligations under law.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "12. Disclaimer of Warranties",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "The App is provided on an 'as is' and 'as available' basis. We do not guarantee:",
                style: TextStyle(),
              ),
              Text(
                "•	The uninterrupted, error-free, or secure operation of the App.",
                style: TextStyle(),
              ),
              Text(
                "•	That the App will meet your specific expectations or requirements.",
                style: TextStyle(),
              ),
              Text(
                "•	To the fullest extent permitted by law, The Society Gate disclaims all warranties, express or implied, including merchantability and fitness for a particular purpose.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "13. Limitation of Liability",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "To the maximum extent allowed by law:",
                style: TextStyle(),
              ),
              Text(
                "•	The Company shall not be liable for any indirect, incidental, consequential, or punitive damages, including loss of profits, data, or goodwill.",
                style: TextStyle(),
              ),
              Text(
                "•	Our total liability for any claim arising from your use of the App shall not exceed the subscription fee paid (if any) during the 12 months preceding the claim.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "14. Indemnity",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "You agree to indemnify, defend, and hold harmless The Society Gate, its affiliates, officers, employees, and agents from any and all claims, damages, liabilities, and costs arising from:",
                style: TextStyle(),
              ),
              Text(
                "•	Your use or misuse of the App.",
                style: TextStyle(),
              ),
              Text(
                "•	Your breach of these Terms.",
                style: TextStyle(),
              ),
              Text(
                "•	Your violation of any rights of a third party.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "15. Compliance with Indian Laws",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "The Society Gate is operated in accordance with the laws of India, including the Digital Personal Data Protection Act, 2023, the Information Technology Act, 2000, and related rules and amendments.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "16. Changes to Terms",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "We may revise these Terms from time to time. The updated Terms will be posted on the App or our website and updated with the “Effective Date” at the top. Continued use of the App after such changes will constitute your acceptance of the revised Terms.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "17. Governing Law and Dispute Resolution",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "These Terms are governed by the laws of India. In case of disputes:",
                style: TextStyle(),
              ),
              Text(
                "You agree to first contact us for informal resolution.",
                style: TextStyle(),
              ),
              Text(
                "If unresolved, disputes shall be subject to the exclusive jurisdiction of the courts located in Mumbai, India.",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "18. Contact Information",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "For any concerns, questions, or to exercise your rights under applicable data protection laws, please contact us at:",
                style: TextStyle(),
              ),
              Text(
                "Email: ",
                style: TextStyle(),
              ),
              Text(
                "Phone: ",
                style: TextStyle(),
              ),
              Text(
                "Website: ",
                style: TextStyle(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "19. Entire Agreement",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "These Terms, along with our Privacy Policy, constitute the entire agreement between you and The Society Gate regarding the use of the App and supersede any prior agreements or understandings.",
                style: TextStyle(),
              ),
              Text(
                "Thank you for choosing The Society Gate — Your Society Management Partner.",
                style: TextStyle(),
              ),
              Text(
                "By using The Society Gate’s services, the Client acknowledges that they have read, understood, and agree to these Terms and Conditions.",
                style: TextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
