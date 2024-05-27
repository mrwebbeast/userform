import "package:flutter/material.dart";

import "package:mrwebbeast/core/enum/enums.dart";
import "package:mrwebbeast/features/users/models/user_data.dart";

import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";
import "package:mrwebbeast/utils/functions/show_snack_bar.dart";
import "package:mrwebbeast/utils/widgets/button/app_button.dart";
import "package:mrwebbeast/utils/widgets/common/app_text_field.dart";

import "package:mrwebbeast/utils/formatters/validators.dart";

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key, required this.user});

  final UserData? user;

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  late UserData? user = widget.user;
  late TextEditingController nameCtrl = TextEditingController(text: user?.name ?? "");
  late TextEditingController emailCtrl = TextEditingController(text: user?.email ?? "");
  late String? gender = user?.gender;

  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user != null ? "Edit User" : "Add User"),
      ),
      body: Form(
        key: userFormKey,
        child: ListView(
          children: [
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
            Container(
              margin: const EdgeInsets.only(left: 24, right: 24, top: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String?>(
                value: gender,
                isExpanded: true,
                decoration: const InputDecoration(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                validator: (val) {
                  return Validator.requiredValidator(val, "Gender");
                },
                alignment: Alignment.center,
                items: Genders.values.map((element) {
                  return DropdownMenuItem<String?>(
                    value: element.value,
                    child: Text(element.value),
                  );
                }).toList(),
                onChanged: (val) {},
              ),
            ),
            AppButton(
              height: 45,
              text: user != null ? "Add" : "Update",
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
    if (userFormKey.currentState?.validate() == true) {
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
    if (userFormKey.currentState?.validate() == true) {
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
}
