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

  List<UserData?>? getUsers() {
    List<UserData?>? users = [];
    List<dynamic>? localProducts = database.get("users");
    debugPrint("Fetched ${localProducts?.length} UserData from LocalDatabase");
    for (final UserData? data in localProducts ?? []) {
      users.add(data);
    }

    BuildContext? context = getContext();
    if (context != null) {
      context.read<UsersController>().updateLocalDatabaseUsers(users);
    }
    return users;
  }

  saveUsers({required List<UserData?>? users}) {
    database.put("users", users);
  }
}
