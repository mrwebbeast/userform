import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:mrwebbeast/core/enum/enums.dart";
import "package:mrwebbeast/features/users/controller/users_controller.dart";
import "package:mrwebbeast/features/users/models/user_data.dart";

import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";
import "package:mrwebbeast/utils/functions/show_snack_bar.dart";
import "package:mrwebbeast/utils/widgets/button/app_button.dart";
import "package:mrwebbeast/utils/widgets/common/app_text_field.dart";

import "package:mrwebbeast/utils/formatters/validators.dart";
import "package:provider/provider.dart";

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key, required this.user, this.index});

  final int? index;
  final UserData? user;

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  late int? index = widget.index;
  late UserData? user = widget.user;
  late bool editMode = index != null;
  late TextEditingController nameCtrl = TextEditingController(text: user?.name ?? "");
  late TextEditingController emailCtrl = TextEditingController(text: user?.email ?? "");
  late String? gender = user?.gender;

  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? "Edit User" : "Add User"),
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

            RadioMenuButton(
              value: Genders.male.value,
              toggleable: true,
              groupValue: "gender",
              onChanged: (val) {
                gender = val;
                setState(() {});
              },
              child: Text(Genders.male.value),
            ),
            RadioMenuButton(
              toggleable: true,
              value: Genders.female.value,
              groupValue: "gender",
              onChanged: (val) {
                gender = val;
                setState(() {});
              },
              child: Text(Genders.female.value),
            ),
            // Container(
            //   margin: const EdgeInsets.only(left: 24, right: 24, top: 12),
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade300.withOpacity(0.7),
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: DropdownButtonFormField<String?>(
            //     value: gender,
            //     isExpanded: true,
            //     decoration: const InputDecoration(
            //       border: InputBorder.none,
            //       // prefixIcon: Icon(Icons.person,color: primaryColor,),
            //     ),
            //     hint: const Row(
            //       children: [Text("Select Gender")],
            //     ),
            //     padding: const EdgeInsets.symmetric(horizontal: 12),
            //     validator: (val) {
            //       return Validator.requiredValidator(val, "Gender");
            //     },
            //     alignment: Alignment.center,
            //     items: Genders.values.map((element) {
            //       return DropdownMenuItem<String?>(
            //         value: element.value,
            //         child: Text(element.value),
            //       );
            //     }).toList(),
            //     onChanged: (val) {
            //       gender = val;
            //       setState(() {});
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: AppButton(
        height: 45,
        text: user != null ? "Update" : "Add",
        backgroundColor: context.colorScheme.primary,
        fontSize: 18,
        onPressed: () {
          manageUser(context);
        },
        mainAxisAlignment: MainAxisAlignment.center,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 24),
      ),
    );
  }

  manageUser(BuildContext context) async {
    if (userFormKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      UserData user = UserData(
        name: nameCtrl.text,
        email: emailCtrl.text,
        gender: gender,
      );
      if (editMode) {
        await context.read<UsersController>().editUser(index: index, user: user);
      } else {
        await context.read<UsersController>().addUser(user: user);
      }
      if (context.mounted) {
        context.pop();
      }
    } else {
      showSnackBar(text: "All Fields Are Required", color: Colors.red);
    }
  }
}
