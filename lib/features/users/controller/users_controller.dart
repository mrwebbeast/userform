import "package:flutter/material.dart";
import "package:mrwebbeast/features/users/models/user_data.dart";
import "package:mrwebbeast/services/database/local_database.dart";
import "package:mrwebbeast/utils/functions/show_snack_bar.dart";

class UsersController extends ChangeNotifier {
  List<UserData?>? users;

  ///1) Add User...

  addUser({required UserData user}) {
    users ??= [];
    users?.add(user);
    showSnackBar(text: "Succesfully Added ${user.name}", color: Colors.green);
    updateLocalDatabaseUsers(users);
    notifyListeners();
  }

  ///2) Edit User...

  editUser({
    required int? index,
    required UserData user,
  }) {
    if (index != null) {
      users ??= [];
      users?[index] = user;
      showSnackBar(text: "Succesfully Updated ${user.name}", color: Colors.green);
      updateLocalDatabaseUsers(users);
      notifyListeners();
    }
  }

  ///3) Update User in LocalDatabase...

  updateLocalDatabaseUsers(List<UserData?>? users) {
    if (users != null) {
      this.users = users;
      LocalDatabase().saveUsers(users: users);
    }
    notifyListeners();
  }
}
