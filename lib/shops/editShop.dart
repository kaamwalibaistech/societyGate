import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../constents/local_storage.dart';
import '../constents/sizedbox.dart';
import '../models/shoplist_model.dart';
import 'bloc/dailyneeds_bloc.dart';
import 'network/shop_apis.dart';

class Editshop extends StatefulWidget {
  final ShopListModel? shopListModel;
  final int index;
  const Editshop({
    super.key,
    this.shopListModel,
    required this.index,
  });

  @override
  State<Editshop> createState() => _EditshopState();
}

class _EditshopState extends State<Editshop> {
  final _formKey = GlobalKey<FormState>();
  late String shopName, shopType, ownerName, phone, address;

  @override
  void initState() {
    super.initState();
    gg();
  }

  gg() {
    setState(() {
      shopName = widget.shopListModel!.data![widget.index].shopName.toString();
      shopType = widget.shopListModel!.data![widget.index].shopType.toString();
      ownerName = widget.shopListModel!.data![widget.index].name.toString();
      phone = widget.shopListModel!.data![widget.index].phone.toString();
      address = widget.shopListModel!.data![widget.index].address.toString();
    });
  }

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected.')),
        );
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
      print('PlatformException: ${e.code} - ${e.message}');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred.')),
      );
      print('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.index.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Shop",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade100,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 32),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 1, color: Colors.blue),
                color: Colors.white),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(children: [
                  CircleAvatar(
                    radius: 80,
                    child: Image.asset(
                      'lib/assets/store.png',
                      scale: 0.7,
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.photo_library_rounded,
                      size: 40,
                      color: Colors.blue,
                    ),
                  )
                ]),
              ),
              sizedBoxH15(context),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    inputFeild("Shop Name", "Enter shop name",
                        (val) => shopName = val, shopName),
                    inputFeild("Shop Type", "Enter shop type",
                        (val) => shopType = val, shopType),
                    inputFeild("Owner Name", "Enter owner name",
                        (val) => ownerName = val, ownerName),
                    inputFeild("Phone", "Enter phone number",
                        (val) => phone = val, phone,
                        isPhone: true),
                    inputFeild("Shop Address", "Enter shop address",
                        (val) => address = val, address),
                    sizedBoxH30(context),
                    SizedBox(
                      width: 220,
                      height: 50,
                      child: ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.blue.shade100,
                          ),
                          onPressed: () async {
                            final LoginModel =
                                LocalStoragePref().getLoginModel();
                            final status = await updateShopAPI(
                                widget.shopListModel?.data?[widget.index].shopId
                                        .toString() ??
                                    "",
                                LoginModel?.user?.societyId.toString() ?? '',
                                shopName,
                                shopType,
                                ownerName,
                                phone,
                                address);
                            if (status == 200) {
                              bootomSheet();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Error! Please try again.");
                            }
                          },
                          child: const Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                    ),
                    sizedBoxH30(context),
                    sizedBoxH30(context),
                    // sizedBoxH30(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputFeild(String title, String hint, Function(String) onChanged,
      String initialValue,
      {bool isPhone = false}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(30.0),
          shadowColor: Colors.black26,
          child: TextFormField(
            initialValue: initialValue,
            keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
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
                // if (_currentStep < totalSteps - 1) {
                //   setState(() {
                //     _currentStep++;
                //     _pageController.nextPage(
                //       duration: const Duration(milliseconds: 300),
                //       curve: Curves.easeInOut,
                //     );
                //   });
                // } else {
                //   log("Shop Name: $shopName, Type: $shopType, Owner: $ownerName, Phone: $phone, Address: $address");
                //   // Submit form or navigate to next page
                // }
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
      ),
    );
  }

  bootomSheet() {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) => BottomSheet(
            onClosing: () {},
            builder: (context) => Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                        // child: Lottie.asset(
                        //   "lib/assets/lottie_json/addingshop.json",
                        //   repeat: false,
                        //   height: 200,
                        // ),
                        child: Image.asset(
                          'lib/assets/store.png',
                          scale: 0.6,
                        ),
                      ),
                      const Text(
                        "Shop Updated!",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            letterSpacing: 1),
                      ),
                      sizedBoxH20(context),
                      const Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          "Your shop details are successfully updated!\n changes will be reflact soon!"),
                      sizedBoxH30(context),
                      SizedBox(
                        width: 220,
                        height: 40,
                        child: ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.blue.shade400,
                            ),
                            onPressed: () {
                              context
                                  .read<DailyneedsBloc>()
                                  .add(GetShopsList());

                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Continue",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                )));
  }
}
