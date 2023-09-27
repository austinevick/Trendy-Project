import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/auth/user_model.dart';
import '../../provider/user_profile_provider.dart';
import '../auth/form_validation.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';
import 'user_avatar.dart';

class EditProfile extends StatefulWidget {
  final UserResponseData data;
  const EditProfile({super.key, required this.data});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formkey = GlobalKey<FormState>();
  final fname = TextEditingController();
  final lname = TextEditingController();
  final email = TextEditingController();
  final about = TextEditingController();
  final profession = TextEditingController();

  bool isSelected = false;
  XFile imageFile = XFile('');

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = image!;
      isSelected = true;
    });
  }

  @override
  void initState() {
    fname.text = widget.data.firstName!;
    lname.text = widget.data.lastName!;
    email.text = widget.data.email!;
    about.text = widget.data.about!;
    profession.text = widget.data.profession!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                UserAvatar(
                    isSelected: isSelected,
                    imageFile: imageFile.path,
                    showIcon: true,
                    image: widget.data.imageUrl,
                    onTap: () => pickImage(),
                    icon: Icons.camera_alt),
                const SizedBox(height: 30),
                CustomTextfield(
                    controller: fname,
                    hintText: 'First name',
                    validator: (value) =>
                        value!.isEmpty ? 'Field is required' : null),
                const SizedBox(height: 16),
                CustomTextfield(
                    controller: lname,
                    hintText: 'Last name',
                    validator: (value) =>
                        value!.isEmpty ? 'Field is required' : null),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: email,
                  hintText: 'Email',
                  textCapitalization: TextCapitalization.none,
                  validator: (val) => validateEmail(val!),
                ),
                const SizedBox(height: 16),
                CustomTextfield(
                    controller: profession,
                    hintText: 'Profession',
                    validator: (value) =>
                        value!.isEmpty ? 'Field is required' : null),
                const SizedBox(height: 16),
                CustomTextfield(
                  controller: about,
                  textCapitalization: TextCapitalization.sentences,
                  hintText: 'Bio',
                  maxLines: 5,
                ),
                const SizedBox(height: 35),
                Consumer(builder: (context, ref, _) {
                  final provider = ref.read(userProfileProvider);
                  return CustomButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        if (imageFile.path.isEmpty) {
                          await provider.updateUserData(
                              firstName: fname.text.trim(),
                              lastName: lname.text.trim(),
                              email: email.text.trim(),
                              profession: profession.text.trim(),
                              about: about.text.trim(),
                              imageUrl: widget.data.imageUrl);
                        } else {
                          final imageUrl = await provider
                              .uploadImageToCloudinary(File(imageFile.path));
                          await provider.updateUserData(
                              firstName: fname.text.trim(),
                              lastName: lname.text.trim(),
                              email: email.text.trim(),
                              profession: profession.text.trim(),
                              about: about.text.trim(),
                              imageUrl: imageUrl!);
                        }
                      }
                    },
                    text: 'Save',
                  );
                }),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CropImage extends StatefulWidget {
  final Uint8List image;
  const CropImage({super.key, required this.image});

  @override
  State<CropImage> createState() => _CropImageState();
}

class _CropImageState extends State<CropImage> {
  final controller = CropController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Crop(
            baseColor: Colors.white,
            image: widget.image,
            controller: controller,
            onCropped: (value) {
              Navigator.of(context).pop(value);
            },
          ),
          Positioned(
            top: 45,
            right: 16,
            child: CustomButton(
              height: 40,
              color: Colors.black54.withOpacity(0.8),
              width: 100,
              onPressed: () {
                controller.crop();
              },
              text: 'Crop',
            ),
          )
        ],
      ),
    );
  }
}
