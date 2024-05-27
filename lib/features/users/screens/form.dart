import "package:flutter/material.dart";
import "package:mrwebbeast/core/enum/enums.dart";
import "package:mrwebbeast/features/users/controller/users_controller.dart";
import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";
import "package:mrwebbeast/utils/formatters/validators.dart";
import "package:mrwebbeast/utils/theme/shadows.dart";
import "package:mrwebbeast/utils/widgets/common/app_text_field.dart";

import "package:mrwebbeast/utils/theme/colors.dart";
import "package:mrwebbeast/features/users/models/user_data.dart";
import "package:provider/provider.dart";

class UserForm extends StatefulWidget {
  const UserForm({super.key, required this.index, this.user});

  final int index;
  final UserData? user;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  late int index = widget.index;
  late UserData? user = widget.user;
  @override
  Widget build(BuildContext context) {
    return Consumer<UsersController>(builder: (context, controller, child) {
      GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
      user = controller.formUsers?.elementAt(index);
      return Form(
        key: userFormKey,
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 24),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: primaryBoxShadow(context),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: primaryColor,
                    child: Text(
                      "${index + 1}",
                      style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<UsersController>().removeFormUser(index: index);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              AppTextField(
                initialValue: user?.name,
                autofocus: true,
                prefixIcon: Icon(Icons.person, color: context.colorScheme.primary),
                validator: (val) {
                  return Validator.nameValidator(val);
                },
                labelText: "Name",
                hintText: "Name",
                onChanged: (val) {
                  context.read<UsersController>().changeName(index: index, val: val);
                },
                margin: const EdgeInsets.only(left: 8, right: 8, top: 16),
              ),
              AppTextField(
                initialValue: user?.email,
                autofocus: true,
                prefixIcon: Icon(Icons.email_outlined, color: context.colorScheme.primary),
                validator: (val) {
                  return Validator.emailValidator(val);
                },
                labelText: "Email",
                hintText: "Email",
                onChanged: (val) {
                  context.read<UsersController>().changeEmail(index: index, val: val);
                },
                margin: const EdgeInsets.only(left: 8, right: 8, top: 12),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: Genders.values.length,
                  itemBuilder: (context, radioButtonIndex) {
                    var data = Genders.values.elementAt(radioButtonIndex).value;
                    return RadioMenuButton(
                      value: data,
                      toggleable: true,
                      groupValue: user?.gender,
                      onChanged: (val) {
                        context.read<UsersController>().changeGender(index: index, val: val);
                      },
                      child: Text(data),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
