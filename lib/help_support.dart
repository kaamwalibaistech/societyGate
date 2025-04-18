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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Get Support",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                  child: Image.asset(
                    "lib/assets/help_desk.png.png",
                    height: 150,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(
                    "Ask us suggest any way we can improve",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                  "Issue type",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
              sizedBoxH10(context),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Enter topic / Issue type",
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  "message",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
              sizedBoxH10(context),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: messageController,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: "Enter your message",
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
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
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Center(
                          child: Text(
                        "Submit message",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
