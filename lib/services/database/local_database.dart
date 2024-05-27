import "package:flutter/cupertino.dart";
import "package:hive_flutter/adapters.dart";
import "package:mrwebbeast/core/config/app_config.dart";
import "package:mrwebbeast/features/users/controller/users_controller.dart";

import "package:mrwebbeast/utils/functions/app_functions.dart";
import "package:provider/provider.dart";

import "package:mrwebbeast/features/users/models/user_data.dart";

class LocalDatabase {
  ///Hive Database Initialization....

  static Future initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserDataAdapter());
    await Hive.openBox(AppConfig.databaseName);
  }

  ///Hive Database Box....
  Box database = Hive.box(AppConfig.databaseName);

  ///Access Local Database data...

  List<List<UserData?>?>? getUsers() {
    List<List<UserData?>?>? groupUsers = [];
    List<dynamic>? localGroupUsers = database.get("users");
    debugPrint("Fetched ${localGroupUsers?.length} UserData from LocalDatabase");
    for (int index = 0; index < (localGroupUsers?.length ?? 0); index++) {
      List<dynamic>? data = localGroupUsers?.elementAt(index);
      List<UserData?> users = [];
      for (final UserData? user in data ?? []) {
        debugPrint("data ${user?.name}");
        users.add(user);
      }
      groupUsers.add(users);
    }

    BuildContext? context = getContext();
    if (context != null) {
      context.read<UsersController>().updateLocalDatabaseUsers(groupUsers);
    }
    return groupUsers;
  }

  saveUsers({required List<List<UserData?>?>? users}) {
    database.put("users", users);
  }
}
