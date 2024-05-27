import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mrwebbeast/features/users/controller/users_controller.dart";
import "package:mrwebbeast/features/users/models/user_data.dart";
import "package:mrwebbeast/features/users/screens/users_form_screen.dart";
import "package:mrwebbeast/utils/extension/normal/build_context_extension.dart";
import "package:mrwebbeast/utils/extension/null_safe/null_safe_list_extension.dart";
import "package:mrwebbeast/utils/theme/colors.dart";
import "package:mrwebbeast/utils/theme/shadows.dart";

import "package:mrwebbeast/core/routes/route_configs.dart";
import "package:mrwebbeast/utils/widgets/common/no_data_found.dart";
import "package:provider/provider.dart";

import "package:mrwebbeast/services/database/local_database.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      LocalDatabase().getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              context.push(Routes.manageUsers);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<UsersController>(
        builder: (context, controller, child) {
          List<UserData?>? users = controller.users;

          return users.haveData
              ? ListView.builder(
                  itemCount: users?.length,
                  itemBuilder: (context, index) {
                    UserData? user = users?.elementAt(index);
                    return UserCard(
                      index: index,
                      user: user,
                    );
                  },
                )
              : const NoDataFound(
                  message: "No Users Found",
                );
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
    required this.index,
  });

  final int index;
  final UserData? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: primaryBoxShadow(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                child: Text(
                  "${index + 1}",
                  style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? '',
                        style: context.textTheme.titleMedium?.copyWith(color: primaryColor),
                      ),
                      Text(
                        "Gender :- ${user?.gender ?? ""}",
                        style: context.textTheme.bodyMedium,
                      ),
                      Text(
                        "Email  :- ${user?.email ?? ""}",
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push(Routes.manageUsers, extra: UserFormScreen(index: index, user: user));
                    },
                    child: const Icon(
                      Icons.edit,
                      color: primaryColor,
                      size: 18,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "Edit",
                      style: TextStyle(color: primaryColor, fontSize: 12),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
