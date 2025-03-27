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
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 19, 52, 84),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            "Privacy Policy",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                  textAlign: TextAlign.justify,
                  "* At The Society Gate , we value your privacy and are committed to protecting the personal information that you share with us. This Privacy Policy explains the types of information we collect, how we use it, how we protect it, and the rights you have regarding your personal data. This policy applies to all users of The Society Gate mobile application (hereinafter referred to as 'the App') for Android devices. The App is designed to provide subscription-based services for managing and facilitating residential society operations."),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                    textAlign: TextAlign.justify,
                    "* By using The Society Gate App, you consent to the collection and use of your information as described in this Privacy Policy."),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 1.0),
                child: Text(
                  "1. Information We Collect",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "To provide and improve our services, we collect several types of information from users:",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "When you create an account or use our services, we may collect personal details such as your name, address, phone number, email address, and other necessary information to facilitate our services.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "The App may collect your device's location to provide services such as booking amenities, managing visitor entries, and enhancing the user experience.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "The App requires access to your device’s camera and gallery for uploading documents, photos, or visitor images. You may grant or deny this permission via your device's settings.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "For maintenance bill payments, we use third-party payment gateways. We do not store sensitive financial information, such as credit card details, on our servers.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "We collect data on how you interact with the App, including the features you use, pages visited, and the duration of your interactions. This helps us enhance functionality and user experience.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "The App provides a messaging feature, and we collect data related to your chat interactions for user communication between admins, members, and watchmen.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "2. Types of Users",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "The Society Gate App is designed for three types of users, each with specific levels of access:",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Admin users can register new users, manage data, send notices, generate visitor gate passes (sent via external mediums), manage rent agreements,  add or view shop listings and can also chat with other members of the society in the said app.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Society members can view notices, book amenities, pay maintenance bills through third-party payment gateways, view shop listings, generate gate pass for their visitors, add their family members in the app and can also chat with other members of the society in the said app.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Watchmen can manage visitor details, approve visitors, access the members list and can also chat with other members of the society in the said app.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Each user role has different access rights and functionalities within the App.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "3. How We Use Your Information",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "We use the collected data for the following purposes:",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "To allow users to access features like registration, visitor management, rent agreement handling, notices, amenities booking, and maintenance bill payments.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "To enhance the App’s performance, user interface, and functionality based on user feedback and usage patterns.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "To send notices, visitor passes, and updates regarding the App's features, including payment receipts, notices, and rent agreements.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "For processing maintenance bill payments through secure third-party payment gateways. We do not store any sensitive payment information.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "To protect the App’s security, prevent fraud, and comply with applicable laws, including the Indian Digital Personal Data Protection Act, 2023 and other related data protection laws.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "4. Data Sharing and Disclosure",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "We may share your information under the following circumstances:",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "We may share data with third-party service providers who assist with our services, such as payment gateways, hosting services, and technical support. We may disclose your information if required to do so by law, including to comply with legal obligations, protect the rights of The Society Gate, and ensure the safety of our users.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "In the event of a merger, acquisition, or sale of assets, your information may be transferred as part of that transaction, subject to this Privacy Policy.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "5. Data Security",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "We take reasonable measures to protect your personal data from unauthorized access, alteration, disclosure, or destruction. However, please note that no method of data transmission over the internet or electronic storage is 100% secure, and we cannot guarantee the absolute security of your information.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "6. Data Retention",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "We retain your personal information for as long as necessary to provide our services and to comply with legal and regulatory obligations. If you wish to delete your account or any personal data, please contact us, and we will comply with your request as required by the Digital Personal Data Protection Act, 2023.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "7. Your Rights and Choices",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "As per the Digital Personal Data Protection Act, 2023 and other applicable data protection laws in India, you have the following rights:",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "You can request access to your personal data and ask for corrections if the information is inaccurate or incomplete.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "You can request the deletion of your account and personal data, subject to certain exceptions under applicable laws.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "You have the right to withdraw your consent for specific data collection, such as location data or camera access. This may impact the functionality of the App.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "You may request a copy of your personal data in a structured, commonly used, and machine-readable format.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "You can object to the processing of your personal data in certain situations or request that we restrict how we process your data.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "To exercise any of these rights, please contact us using the details provided below.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "8. Third-Party Links and Services",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "The App may contain links to third-party websites, including payment gateways and other services. We are not responsible for the privacy practices or content of these third-party services, and we encourage you to review their privacy policies before providing any personal information.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "9. Children’s Privacy",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "The App is not intended for children under the age of 13, and we do not knowingly collect personal information from children. If we become aware that a child under 13 has provided us with personal information, we will take steps to delete that information.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "10. Compliance with Indian Data Protection Laws",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "We comply with the Digital Personal Data Protection Act, 2023 (India) and other applicable data protection laws in India. We are committed to safeguarding your personal data and ensuring that it is processed lawfully, fairly, and transparently. Your privacy rights under Indian law are respected, and we strive to provide you with the control over your personal information.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "11. Changes to This Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "We may update this Privacy Policy from time to time. Any changes will be reflected by updating the 'Effective Date' at the top of this policy. We encourage you to review this Privacy Policy periodically to stay informed about how we protect your information.",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "12. Contact Us",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "If you have any questions, concerns, or requests regarding this Privacy Policy or how we handle your personal data, please contact us:",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Email: ",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Phone: ",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Website: ",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  "By using The Society Gate App, you agree to the collection and use of your personal information in accordance with this Privacy Policy. Thank you for trusting us with your data.",
                ),
              ),
            ]),
          ),
        ));
  }
}
