import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:my_society/constents/sizedbox.dart';
import 'package:my_society/shops/bloc/dailyneeds_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddShop extends StatefulWidget {
  const AddShop({super.key});

  @override
  State<AddShop> createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  int _currentStep = 0;
  final int totalSteps = 5;

  String shopName = "", shopType = "", ownerName = "", phone = "", address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image at top
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'lib/assets/addshop_appbar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Timeline Progress Indicator
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 25),
              child: Row(
                children: List.generate(totalSteps, (index) {
                  return Expanded(
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 35,
                          width: index == _currentStep ? 35 : 24,
                          decoration: BoxDecoration(
                            color: index <= _currentStep
                                ? Colors.green
                                : Colors.blueGrey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        if (index < totalSteps - 1)
                          Expanded(
                            child: Container(
                              height: 3,
                              color: index < _currentStep
                                  ? Colors.green
                                  : Colors.grey.shade400,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // Step Content (Inputs)
            Form(
              key: _formKey,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    buildStep("Shop Name", "Enter shop name",
                        (val) => shopName = val),
                    buildStep("Shop Type", "Enter shop type",
                        (val) => shopType = val),
                    buildStep("Owner Name", "Enter owner name",
                        (val) => ownerName = val),
                    buildStep(
                        "Phone", "Enter phone number", (val) => phone = val,
                        isPhone: true),
                    buildStep("Shop Address", "Enter shop address",
                        (val) => address = val),
                  ],
                ),
              ),
            ),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_currentStep > 0)
                    ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(color: Colors.deepPurpleAccent),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.deepPurple.shade400),
                      onPressed: () {
                        setState(() {
                          _currentStep--;
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        });
                      },
                      child: const Text("Previous"),
                    ),
                  SizedBox(
                    height: 45,
                    width: 120,
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          elevation: 6,
                          shadowColor: Colors.deepPurple.shade100,
                          backgroundColor: Colors.deepPurple.shade400,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_currentStep < totalSteps - 1) {
                            setState(() {
                              _currentStep++;
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            });
                          } else {
                            log("Shop Name: $shopName, Type: $shopType, Owner: $ownerName, Phone: $phone, Address: $address");
                            // Submit form or navigate to next
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddingShop(
                                          shopName: shopName,
                                          shopType: shopType,
                                          ownerName: ownerName,
                                          phone: phone,
                                          shopAddress: address,
                                        )));
                          }
                        }
                      },
                      child: Text(
                        _currentStep == totalSteps - 1 ? "Add Shop" : "Next",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build step content with validation
  Widget buildStep(String title, String hint, Function(String) onChanged,
      {bool isPhone = false}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.deepPurple,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Colors.black26,
              child: TextFormField(
                autofocus: true,
                keyboardType:
                    isPhone ? TextInputType.phone : TextInputType.text,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "This field cannot be empty!";
                  }
                  if (isPhone && (value.length < 10 || value.length > 10)) {
                    return "Enter a valid 10-digit phone number!";
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (_formKey.currentState!.validate()) {
                    if (_currentStep < totalSteps - 1) {
                      setState(() {
                        _currentStep++;
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      });
                    } else {
                      log("Shop Name: $shopName, Type: $shopType, Owner: $ownerName, Phone: $phone, Address: $address");
                      // Submit form or navigate to next page
                    }
                  }
                },
                onChanged: onChanged,
                cursorColor: Colors.deepPurple,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.blueGrey[600]),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Colors.deepPurple.shade400,
                      width: MediaQuery.of(context).size.width * 0.005,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddingShop extends StatefulWidget {
  final String shopName, shopType, ownerName, phone, shopAddress;

  const AddingShop({
    super.key,
    required this.shopName,
    required this.shopType,
    required this.ownerName,
    required this.phone,
    required this.shopAddress,
  });

  @override
  State<AddingShop> createState() => _AddingShopState();
}

class _AddingShopState extends State<AddingShop> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DailyneedsBloc>().add(AddShopEvent(
          shopName: widget.shopName,
          shopType: widget.shopType,
          ownerName: widget.ownerName,
          shopPhone: widget.phone,
          shopAddress: widget.shopAddress,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // Log shop details
    // log("Shop Name: $shopName, Type: $shopType, Owner: $ownerName, Phone: $phone, Address: $shopAddress");

    return BlocListener<DailyneedsBloc, DailyneedsState>(
      listener: (context, state) async {
        if (state is ShopAddSuccessState) {
          await Future.delayed(const Duration(seconds: 5));
          Fluttertoast.showToast(msg: "Shop added successfully!");
          Navigator.pop(context);
          Navigator.pop(context);
          context.read<DailyneedsBloc>().add(GetShopsList());
          Navigator.pop(context);
        } else if (state is ShopAddErrorState) {
          await Future.delayed(const Duration(seconds: 5));
          Fluttertoast.showToast(msg: state.msg);
          showError(state.msg.toString());
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "lib/assets/lottie_json/addingshop.json",
                repeat: true,
                height: 220,
              ),
              const Text(
                "Adding shop ...",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.red,
                ),
              ),
              sizedBoxH30(context),
            ],
          ),
        ),
      ),
    );
  }

  void showError(String message) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                message,
                textAlign: TextAlign.center,
              ),
              icon: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 80,
              ),
            ));
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
