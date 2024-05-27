import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:mrwebbeast/features/users/controller/users_controller.dart";
import "package:mrwebbeast/features/users/models/user_data.dart";
import "package:mrwebbeast/utils/extension/null_safe/null_safe_list_extension.dart";
import "package:mrwebbeast/utils/theme/colors.dart";
import "package:mrwebbeast/utils/theme/shadows.dart";

import "package:mrwebbeast/core/routes/route_configs.dart";
import "package:mrwebbeast/utils/widgets/common/no_data_found.dart";
import "package:provider/provider.dart";

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
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
                    return Container(
                      margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: primaryBoxShadow(context),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text("${index + 1}) Sahil Ranout | Male"),
                        subtitle: const Text("mrwebbeast@gmail.com"),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                context.push(Routes.manageUsers, extra: UserData());
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
                        ),
                      ),
                    );
                  },
                )
              : const NoDataFound(message: "No Users Found",);
        },
      ),
    );
  }
}
