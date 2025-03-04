import 'package:flutter/material.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController societyNameController = TextEditingController();
  final TextEditingController societyAddressController =
      TextEditingController();
  final TextEditingController totalFlatController = TextEditingController();
  final TextEditingController totalwingsController = TextEditingController();
  bool? swimmingPoolChecked = false;
  bool? gardenChecked = false;
  bool? parkingChecked = false;
  bool? gymChecked = false;
  bool? playGroundChecked = false;
  bool? moreChecked = false;

  List<String> amenities = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f3fa),
      appBar: AppBar(
        backgroundColor: const Color(0xfff0f3fa),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Text(
                "Create an account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    "Log In",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Name",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
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
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Phone Numbers",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: mobileNoController,
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
                    hintText: "+91",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Email",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: emailController,
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
                    hintText: "Enter Email Address",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Society Name",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: societyNameController,
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
                    hintText: "Enter Society Name",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Society Address",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: societyAddressController,
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
                    hintText: "Enter Society Address",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Flats",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            keyboardType: TextInputType.number,

                            controller: totalFlatController,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "please enter numbers!";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              counterText: "",
                              hintText: "Enter Total flats",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Wings",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            keyboardType: TextInputType.number,

                            controller: totalwingsController,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "please enter numbers!";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              counterText: "",
                              hintText: "Enter Total Wings",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  "amenities",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 123, 121, 121)),
                          value: swimmingPoolChecked,
                          onChanged: (newValue) {
                            setState(() {
                              swimmingPoolChecked = newValue;
                              if (swimmingPoolChecked == true) {
                                amenities.add("Swimming Pool");
                              } else {
                                amenities.remove("Swimming Pool");
                              }
                              print(amenities);
                            });
                          }),
                      const Text("Swimming Pool")
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 123, 121, 121)),
                          value: gardenChecked,
                          onChanged: (newValue) {
                            setState(() {
                              gardenChecked = newValue;
                              if (gardenChecked == true) {
                                amenities.add("Garden");
                              } else {
                                amenities.remove("Garden");
                              }
                              print(amenities);
                            });
                          }),
                      const Text("Garden")
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 123, 121, 121)),
                          value: parkingChecked,
                          onChanged: (newValue) {
                            setState(() {
                              parkingChecked = newValue;
                              if (parkingChecked == true) {
                                amenities.add("Parking");
                              } else {
                                amenities.remove("Parking");
                              }
                              print(amenities);
                            });
                          }),
                      const Text("Parking")
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 123, 121, 121)),
                          value: gymChecked,
                          onChanged: (newValue) {
                            setState(() {
                              gymChecked = newValue;
                              if (gymChecked == true) {
                                amenities.add("Gym");
                              } else {
                                amenities.remove("Gym");
                              }
                              print(amenities);
                            });
                          }),
                      const Text("Gym")
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 123, 121, 121)),
                          value: playGroundChecked,
                          onChanged: (newValue) {
                            setState(() {
                              playGroundChecked = newValue;
                              if (playGroundChecked == true) {
                                amenities.add("Playground");
                              } else {
                                amenities.remove("Playground");
                              }
                              print(amenities);
                            });
                          }),
                      const Text("Playground")
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 123, 121, 121)),
                          value: moreChecked,
                          onChanged: (newValue) {
                            setState(() {
                              moreChecked = newValue;
                              if (moreChecked == true) {
                                amenities.add("More");
                              } else {
                                amenities.remove("More");
                              }
                              print(amenities);
                            });
                          }),
                      const Text("More")
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                  child: Text(
                "By Creating account, you agree to our",
                style: TextStyle(color: Colors.black45),
              )),
              Center(
                child: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                      child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
