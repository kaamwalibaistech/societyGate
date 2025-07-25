import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:society_gate/constents/date_format.dart';
import 'package:society_gate/constents/sizedbox.dart';
import 'package:society_gate/dashboard/members/add_fine_page.dart';
import 'package:society_gate/dashboard/members/network/memberslist_api.dart';

class MemberWatchmanDetailPage extends StatefulWidget {
  final dynamic details;
  final String societyName;
  final String societyId;
  const MemberWatchmanDetailPage({
    super.key,
    this.details,
    required this.societyName,
    required this.societyId,
  });

  @override
  State<MemberWatchmanDetailPage> createState() =>
      _MemberWatchmanDetailPageState();
}

class _MemberWatchmanDetailPageState extends State<MemberWatchmanDetailPage> {
  bool isWatchman = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isWatchman = widget.details.urole == "watchman";
    });
  }

  @override
  Widget build(BuildContext context) {
    final member = widget.details;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Section
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(widget
                              .details.profileImage ??
                          "https://ui-avatars.com/api/?background=random&name=${widget.details.uname}."),
                    ),
                    sizedBoxH10(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          member.uname ?? "",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.verified,
                            color: Colors.green, size: 20),
                      ],
                    ),
                    Text(member.urole?.toUpperCase() ?? "",
                        style: TextStyle(color: Colors.grey.shade600)),
                    sizedBoxH10(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddFinePage(details: widget.details)));
                          },
                          icon: const Icon(Icons.warning_amber_rounded),
                          label: const Text("Add Fine"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        if (isWatchman) sizedBoxW10(context),
                        if (isWatchman)
                          ElevatedButton.icon(
                            onPressed: () => editWatchman(),
                            icon: const Icon(Icons.sensor_occupied_outlined),
                            label: const Text("Edit Details"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
              sizedBoxH20(context),

              // Detail Cards
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.email, color: Colors.deepPurple),
                  title: const Text("Email"),
                  subtitle: Text(member.uemail ?? "Not Available"),
                ),
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.phone_android, color: Colors.teal),
                  title: const Text("Phone"),
                  subtitle: Text(member.uphone ?? "Not Available"),
                ),
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading:
                      const Icon(Icons.apartment_rounded, color: Colors.blue),
                  title: const Text("Society"),
                  subtitle: Text(widget.societyName),
                ),
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.security, color: Colors.green),
                  title: const Text("Approval Status"),
                  subtitle: Text(member.approvalStatus ?? "Pending"),
                ),
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.calendar_month_rounded,
                      color: Colors.pink),
                  title: const Text("Joined On"),
                  subtitle: Text(formatDate(member.createdAt ?? "N/A")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  editWatchman() {
    TextEditingController nameController =
        TextEditingController(text: widget.details.uname ?? "");
    TextEditingController emailController =
        TextEditingController(text: widget.details.uemail);
    TextEditingController mobileNoController =
        TextEditingController(text: widget.details.uphone);
    TextEditingController passwordController = TextEditingController();
    XFile? pickedImage;
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      useRootNavigator: true,
      showDragHandle: true,
      isScrollControlled: true, // Very important
      backgroundColor: Colors.green.shade50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          // final formKey = GlobalKey<FormState>();

          final ImagePicker picker = ImagePicker();

          Future pickImage(BuildContext context) async {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (BuildContext context) {
                return SafeArea(
                  child: Wrap(
                    children: [
                      ListTile(
                          leading:
                              const Icon(Icons.camera_alt, color: Colors.blue),
                          title: const Text('Take Photo'),
                          onTap: () async {
                            final photo = await picker.pickImage(
                                source: ImageSource.camera, imageQuality: 70);
                            if (photo != null) {
                              setState(() {
                                pickedImage = photo;
                              });
                            }
                          }),
                      ListTile(
                        leading: const Icon(Icons.photo_library,
                            color: Colors.green),
                        title: const Text('Choose from Gallery'),
                        onTap: () async {
                          final galleryImage = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 70);
                          if (galleryImage != null) {
                            Navigator.of(context).pop();
                            setState(() {
                              pickedImage = galleryImage;
                            });
                          }
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.close, color: Colors.red),
                        title: const Text('Cancel'),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // buildLabel("Profile Photo"),
                    Center(
                      child: GestureDetector(
                          onTap: () => pickImage(context),
                          child: CircleAvatar(
                              radius: 60,
                              backgroundImage: pickedImage == null
                                  ? CachedNetworkImageProvider(widget
                                          .details.profileImage ??
                                      "https://ui-avatars.com/api/?background=random&name=${widget.details.uname}.")
                                  : FileImage(
                                      File(pickedImage!.path),
                                    ))),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => pickImage(context),
                      child: const Center(
                        child: Text(
                          "Upload Image",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildLabel("Name"),
                    buildTextField(nameController, "Enter name",
                        validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return "Enter a valid name";
                      }
                      return null;
                    }),
                    buildLabel("Email"),
                    buildTextField(emailController, "Enter email",
                        keyboardType: TextInputType.emailAddress),
                    buildLabel("Mobile No."),
                    buildTextField(
                      mobileNoController,
                      "Enter mobile no",
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      validator: (value) {
                        if (value!.length != 10) {
                          return "Mobile no should be 10 digits";
                        }
                        return null;
                      },
                    ),
                    buildLabel("New Password (Optional)"),
                    const Text(
                      "• Enter new password in case you want to change the password.",
                      style: TextStyle(fontSize: 12),
                    ),
                    sizedBoxH10(context),
                    buildTextField(
                      passwordController,
                      "Enter password",
                      // isObscure: true,
                      validator: (value) {
                        if (value == null) {
                          return "Enter password";
                        } else if (value.length < 6) {
                          return "Password Should be 6 digits";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          int? watchmanData = await updateWatchmanApi(
                              widget.societyId,
                              widget.details?.userId ?? "",
                              nameController.text,
                              emailController.text,
                              mobileNoController.text,
                              passwordController.text,
                              "approved",
                              pickedImage?.path.toString() ?? "");
                          if (watchmanData == 200) {
                            Fluttertoast.showToast(
                                msg: "watchmanData!.message.toString()");
                            Navigator.pop(context);
                          } else {
                            /* showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Something went wrong!"),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Text(
                                            (watchmanData!["uemail"] ?? [""])
                                                .join(", ")),
                                      ),
                                      Text((watchmanData.message["uphone"] ??
                                              [""])
                                          .join(", ")),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Text((watchmanData
                                                    .message["profile_image"] ??
                                                [""])
                                            .join(", ")),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Close"),
                                  ),
                                ],
                              ),
                            );*/
                          }
                        },
                        icon: const Icon(Icons.done_outline_rounded),
                        label: const Text("Submit"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    sizedBoxH20(context),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 6, left: 5),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String hint, {
    // bool isObscure = false,
    // bool? isTextVisible,
    // VoidCallback? toggleVisibility,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      // obscureText: isObscure && !(isTextVisible ?? false),
      maxLength: maxLength,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Colors.red),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        counterText: "",
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(14),
        ),
        // suffixIcon: isObscure
        //     ? IconButton(
        //         icon: Icon(
        //           isTextVisible ?? false
        //               ? Icons.visibility
        //               : Icons.visibility_off,
        //         ),
        //         onPressed: toggleVisibility,
        //       )
        //     : null,
      ),
    );
  }
}
