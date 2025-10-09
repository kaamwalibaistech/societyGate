import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:society_gate/community/network/community_apis.dart';
import 'package:society_gate/constents/local_storage.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = path.basename(imagePath);
    final image = File(imagePath);
    final newImage = await image.copy('${directory.path}/$name');
    return newImage;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        if (source == ImageSource.camera) {
          imageFile = await saveImagePermanently(pickedFile.path);
        }
        setState(() => _image = imageFile);
      } else {
        showFloatingSnackBar(
          context,
          message: "No image selected.",
          backgroundColor: Colors.orangeAccent,
          icon: Icons.image_not_supported_rounded,
        );
      }
    } on PlatformException catch (e) {
      showFloatingSnackBar(
        context,
        message: "Error: ${e.message}",
        backgroundColor: Colors.redAccent,
        icon: Icons.error_outline_rounded,
      );
      log('PlatformException: ${e.code} - ${e.message}');
    } catch (e) {
      showFloatingSnackBar(
        context,
        message: "An unexpected error occurred.",
        backgroundColor: Colors.redAccent,
        icon: Icons.warning_amber_rounded,
      );
      log('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Create Post",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 19,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            if (_image == null) {
              showFloatingSnackBar(
                context,
                message: "Please select an image before posting.",
                backgroundColor: Colors.redAccent,
                icon: Icons.image_not_supported_rounded,
              );
              return;
            }
            if (_image!.lengthSync() < 2000000) {
              communityPostInsert(
                titleController.text.trim(),
                descriptionController.text.trim(),
              );
            } else {
              showFloatingSnackBar(
                context,
                message: "Image should be smaller than 2 MB.",
                backgroundColor: Colors.orangeAccent,
                icon: Icons.warning_amber_rounded,
              );
            }
          } else {
            showFloatingSnackBar(
              context,
              message: "Please fill in all required fields.",
              backgroundColor: Colors.redAccent,
              icon: Icons.error_outline_rounded,
            );
          }
        },
        label: const Text(
          "Post",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.send_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 8,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.grey.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a title'
                          : null,
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Give your post a catchy title",
                        filled: true,
                        fillColor: Colors.grey[100],
                        prefixIcon: const Icon(
                          Icons.title_rounded,
                          color: Colors.black54,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Icon(Icons.edit_note_rounded,
                                color: Colors.black54),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter a description'
                                      : null,
                              controller: descriptionController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 7,
                              decoration: const InputDecoration(
                                hintText: "Write something interesting...",
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _showImagePickerSheet(context),
                      child: _image != null
                          ? Hero(
                              tag: "postImage",
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  _image!,
                                  width: double.infinity,
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              height: 220,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  style: BorderStyle.solid,
                                  width: 1.2,
                                ),
                              ),
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined,
                                        color: Colors.black54, size: 40),
                                    SizedBox(height: 10),
                                    Text(
                                      'Tap to select an image',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Select Image From",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageSourceButton(
                      icon: Icons.photo_library_rounded,
                      label: "Gallery",
                      color: Colors.black,
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                    _buildImageSourceButton(
                      icon: Icons.camera_alt_rounded,
                      label: "Camera",
                      color: Colors.deepOrangeAccent,
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSourceButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 130,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: color, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  communityPostInsert(title, description) async {
    EasyLoading.show();
    try {
      final getLoginModel = LocalStoragePref().getLoginModel();
      int? status = await addCommunityPost(
        getLoginModel!.user!.societyId.toString(),
        getLoginModel.user!.userId.toString(),
        title,
        description,
        _image!.path.toString(),
      );

      EasyLoading.dismiss();

      if (status == 200) {
        showFloatingSnackBar(
          context,
          message: "Post created successfully 🎉",
          backgroundColor: Colors.green,
          icon: Icons.check_circle_outline_rounded,
        );
        Future.delayed(const Duration(milliseconds: 800), () {
          Navigator.pop(context);
        });
      } else {
        showFloatingSnackBar(
          context,
          message: "Something went wrong. Please try again.",
          backgroundColor: Colors.redAccent,
          icon: Icons.error_outline_rounded,
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      showFloatingSnackBar(
        context,
        message: "Error: ${e.toString()}",
        backgroundColor: Colors.redAccent,
        icon: Icons.warning_amber_rounded,
      );
      throw Exception(e.toString());
    }
  }
}

// 🌟 Floating Snackbar Helper
void showFloatingSnackBar(
  BuildContext context, {
  required String message,
  Color backgroundColor = Colors.black87,
  IconData icon = Icons.info_outline_rounded,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      duration: const Duration(seconds: 2),
      elevation: 6,
    ),
  );
}
