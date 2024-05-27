import "dart:io";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:image_picker/image_picker.dart";
import "package:mrwebbeast/services/database/local_database.dart";


import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";
import "package:mrwebbeast/utils/functions/app_functions.dart";
import "package:mrwebbeast/utils/functions/pick_image.dart";
import "package:mrwebbeast/utils/functions/show_snack_bar.dart";
import "package:mrwebbeast/utils/widgets/button/app_button.dart";
import "package:mrwebbeast/utils/widgets/common/app_text_field.dart";


import "package:mrwebbeast/utils/theme/colors.dart";

import "package:mrwebbeast/utils/formatters/validators.dart";

import "package:mrwebbeast/utils/widgets/image/image_view.dart";

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  LocalDatabase localDatabase = LocalDatabase();
  late TextEditingController nameCtrl = TextEditingController(text: localDatabase.name ?? "");
  late TextEditingController emailCtrl = TextEditingController(text: localDatabase.email ?? "");
  late TextEditingController mobileCtrl = TextEditingController(text: localDatabase.mobile ?? "");

  late String? profilePhoto = localDatabase.profilePhoto;

  double imageRadius = 110;
  File? image;
  GlobalKey<FormState> editProfileKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        // AuthControllers controllers = Provider.of(context, listen: false);
        // controllers.fetchCountries(context: context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Form(
        key: editProfileKey,
        child: ListView(
          children: [
            GestureDetector(
              onTap: () async {
                addImages();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ImageView(
                        height: imageRadius,
                        width: imageRadius,
                        borderRadiusValue: imageRadius,
                        isAvatar: true,
                        file: image,
                        networkImage: profilePhoto,
                        fit: BoxFit.cover,
                        border: Border.all(color: Colors.grey.shade200),
                        margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 12),
                      ),
                      Positioned(
                        right: -6,
                        bottom: 10,
                        child: Icon(CupertinoIcons.add_circled_solid, size: 24, color: primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppTextField(
              controller: nameCtrl,
              autofocus: true,
              prefixIcon: Icon(Icons.person, color: context.colorScheme.primary),
              validator: (val) {
                return Validator.nameValidator(val);
              },
              labelText: "Name",
              hintText: "Name",
              margin: const EdgeInsets.only(left: 24, right: 24, top: 12),
            ),
            AppTextField(
              controller: emailCtrl,
              autofocus: true,
              prefixIcon: Icon(Icons.email_outlined, color: context.colorScheme.primary),
              validator: (val) {
                return Validator.emailValidator(val);
              },
              labelText: "Email",
              hintText: "Email",
              margin: const EdgeInsets.only(left: 24, right: 24, top: 12),
            ),
            AppTextField(
              controller: mobileCtrl,
              autofocus: true,
              enabled: false,
              labelText: "Mobile Number",
              keyboardType: TextInputType.number,
              prefixIcon: Icon(Icons.call, color: context.colorScheme.primary),
              suffixIcon: Icon(Icons.verified_outlined, color: context.colorScheme.primary, size: 20),
              limit: 10,
              validator: (val) {
                return Validator.numberValidator(val);
              },
              hintText: "Enter Mobile Number",
              margin: const EdgeInsets.only(left: 24, right: 24, top: 14),
            ),

            // CustomTextField(
            //   controller: addressCtrl,
            //   autofocus: true,
            //   minLines: 1,
            //   maxLines: 4,
            //   prefixIcon: const Icon(Icons.location_on, color: primaryColor),
            //   labelText: "Address",
            //   hintText: "Address",
            //   validator: (val) {
            //     return Validator.nameValidator(val);
            //   },
            //   margin: const EdgeInsets.only(left: 24, right: 24, top: 12),
            // ),
            AppButton(
              height: 45,
              text: "Update",
              backgroundColor: context.colorScheme.primary,
              fontSize: 18,
              onPressed: () {
                updateProfile();
              },
              mainAxisAlignment: MainAxisAlignment.center,
              margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 24),
            )
          ],
        ),
      ),
    );
  }

  updateProfile() {
    if (editProfileKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();

      // context.read<AuthControllers>().editProfile(
      //   context: context,
      //   name: nameCtrl.text,
      //   email: emailCtrl.text,
      //   profilePhoto: image,
      // );
    }
  }

  editProfile() async {
    if (editProfileKey.currentState?.validate() == true) {
      // context.read<AuthControllers>().editProfile(
      //   context: context,
      //   fullName: nameController.text,
      //   email: emailController.text,
      //   image: image,
      // );
    } else {
      String error = "Enter all required Data";

      showSnackBar(text: error, error: true);
    }
  }

  Future<void> updateProfileImage({required ImageSource source}) async {
    BuildContext? context = getContext();
    final pickedImg = await ImagePicker().pickImage(source: source);
    if (context != null) {
      if (pickedImg != null) {
        image = File(pickedImg.path);
      }
      if (context.mounted) {
        setState(() {});
        context.pop();
      }
    }
  }

  Future addImages() async {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Change Profile Pic",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PickImageButton(
                      context: context,
                      text: "Camera",
                      icon: Icons.camera,
                      onTap: () {
                        updateProfileImage(source: ImageSource.camera);
                      },
                    ),
                    PickImageButton(
                      context: context,
                      text: "Gallery",
                      icon: Icons.photo,
                      onTap: () {
                        updateProfileImage(source: ImageSource.gallery);
                      },
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
