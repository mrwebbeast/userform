import "package:flutter/material.dart";
import "package:mrwebbeast/features/users/models/user_data.dart";
import "package:mrwebbeast/services/database/local_database.dart";

class UsersController extends ChangeNotifier {
  List<UserData?>? users;

  setUsers(List<UserData?>? users) {
    if (users != null) {
      this.users = users;
      LocalDatabase().saveUsers(users: users);
    }
    notifyListeners();
  }

  addUser({required UserData user}) {
    users ??= [];
    users?.add(user);
    setUsers(users);
    notifyListeners();
  }
}
