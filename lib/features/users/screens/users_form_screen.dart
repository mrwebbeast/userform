import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:mrwebbeast/features/users/controller/users_controller.dart";
import "package:mrwebbeast/features/users/models/user_data.dart";
import "package:mrwebbeast/features/users/screens/form.dart";

import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";
import "package:mrwebbeast/utils/extension/null_safe/null_safe_list_extension.dart";
import "package:mrwebbeast/utils/functions/show_snack_bar.dart";
import "package:mrwebbeast/utils/widgets/button/app_button.dart";
import "package:mrwebbeast/utils/widgets/common/loading_screen.dart";

import "package:mrwebbeast/utils/widgets/common/no_data_found.dart";
import "package:provider/provider.dart";

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key, this.index});

  final int? index;

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  late int? index = widget.index;
  late bool editMode = index != null;
  List<UserData?>? users;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(milliseconds: 100)).then((v) {
        loading = false;
        setState(() {});
      });

      UsersController usersController = Provider.of(context, listen: false);
      usersController.clearFormUsers();

      if (index != null) {
        final List<UserData?>? users = usersController.usersGroups?.elementAt(index!);
        usersController.addFormUsers(users: users);
      } else {
        usersController.addFormUser(user: UserData());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    users = null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersController>(
      builder: (context, controller, child) {
        users = controller.formUsers;
        return Scaffold(
          appBar: AppBar(
            title: Text(editMode ? "Edit Users" : "Add Users"),
            actions: [
              IconButton(
                onPressed: () {
                  controller.addFormUser(user: UserData());
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: loading
              ? const LoadingScreen()
              : users.haveData
                  ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: users?.length,
                    itemBuilder: (context, index) {
                      UserData? user = users?.elementAt(index);
                      return UserForm(
                        index: index,
                        user: user,
                      );
                    },
                  )
                  : const NoDataFound(
                      message: "No User Found",
                    ),
          bottomNavigationBar: AppButton(
            height: 45,
            text: users != null ? "Update" : "Save",
            backgroundColor: context.colorScheme.primary,
            fontSize: 16,
            borderRadius: 50,
            onPressed: () {
              manageUser(context);
            },
            mainAxisAlignment: MainAxisAlignment.center,
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 24),
          ),
        );
      },
    );
  }

  manageUser(BuildContext context) async {
    String? error = context.read<UsersController>().isValidateForm();
    if (error != null) {
      showSnackBar(text: error, color: Colors.red, icon: Icons.error_outline_rounded);
    } else {
      FocusScope.of(context).unfocus();

      if (editMode) {
        await context.read<UsersController>().editUser(index: index, users: users);
      } else {
        await context.read<UsersController>().addUser(users: users);
      }
      if (context.mounted) {
        context.pop();
      }
    }
  }
}
