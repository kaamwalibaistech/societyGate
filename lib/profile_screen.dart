import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    return Scaffold(
        backgroundColor: const Color(0xfff0f3fa),
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back)),
          title: const Text(
            "Edit profile",
            style: TextStyle(fontSize: 16),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Text(
                "Save",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 45,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "Name",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: nameController,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "please enter numbers!";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    counterText: "",
                    hintText: "Enter your name",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "phone number",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: phoneNumberController,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,

                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "please enter numbers!";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    counterText: "",
                    hintText: "[xxx] xx xxxxxx",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "Email",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: phoneNumberController,

                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "please enter numbers!";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    counterText: "",
                    hintText: "Example@gmail.com",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
