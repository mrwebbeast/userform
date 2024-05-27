import "package:flutter/material.dart";
import "package:mrwebbeast/features/users/models/user_data.dart";
import "package:mrwebbeast/services/database/local_database.dart";
import "package:mrwebbeast/utils/functions/show_snack_bar.dart";

import "package:mrwebbeast/utils/formatters/validators.dart";

class UsersController extends ChangeNotifier {
  List<List<UserData?>?>? usersGroups;

  ///1) Add User...

  addUser() {
    usersGroups ??= [];
    usersGroups?.add(formUsers);
    showSnackBar(text: "Succesfully Added", color: Colors.green);
    updateLocalDatabaseUsers(usersGroups);
    notifyListeners();
  }

  ///2) Edit User...

  editUser({
    required int? index,
  }) {
    if (index != null) {
      usersGroups ??= [];
      usersGroups?[index] = formUsers;
      showSnackBar(text: "Succesfully Updated", color: Colors.green);
      updateLocalDatabaseUsers(usersGroups);
      notifyListeners();
    }
  }

  ///3) Update User in LocalDatabase...

  updateLocalDatabaseUsers(List<List<UserData?>?>? usersGroups) {
    if (usersGroups != null) {
      this.usersGroups = usersGroups;
      LocalDatabase().saveUsers(users: usersGroups);
    }
    notifyListeners();
  }

  ///Form

  List<UserData?>? formUsers = [UserData()];
  bool loadingFormUser = false;

  addFormUsers({required List<UserData?>? users}) {
    formUsers = List.from(users as Iterable).cast<UserData?>().toList();
    notifyListeners();
  }

  clearFormUsers({bool? update = true}) {
    formUsers?.clear();
    formUsers = [];
    if (update == true) {
      notifyListeners();
    }
  }

  addFormUser({required UserData? user}) {
    formUsers ?? [];
    formUsers?.add(user);
    notifyListeners();
  }

  changeName({
    required int index,
    required String val,
  }) {
    formUsers?[index]?.name = val;
    notifyListeners();
  }

  changeEmail({
    required int index,
    required String val,
  }) {
    formUsers?[index]?.email = val;
    notifyListeners();
  }

  changeGender({
    required int index,
    required String? val,
  }) {
    debugPrint("index $index");
    formUsers?[index]?.gender = val;
    notifyListeners();
  }

  removeFormUser({
    required int index,
  }) {
    loadingFormUser = true;
    formUsers?.removeAt(index);
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 1)).then((v) {
      showSnackBar(text: "Removed User");
      loadingFormUser = false;
      notifyListeners();
    });
  }

  String? isValidateForm() {
    String? error;

    for (int index = 0; index < (formUsers?.length ?? 0); index++) {
      var data = formUsers?.elementAt(index);
      int formNo = index + 1;
      String? nameError = Validator.nameValidator(data?.name);
      String? emailError = Validator.emailValidator(data?.email);
      if (nameError != null) {
        error = "Name is required in form $formNo";
        return error;
      } else if (emailError != null) {
        error = "Email is required in form $formNo";
        return error;
      } else if (data?.gender == null) {
        error = "Gender is required in form $formNo";
        return error;
      }
    }

    return error;
  }

  @override
  void dispose() {
    formUsers = [];
    super.dispose();
  }
}
