import 'package:flutter/material.dart';
import '../entities/user.dart';
import '../services/service_user.dart';

class UserRequest extends ChangeNotifier {
  List<User>? allUsers;
  bool loading = false;

  getDataUser() async {
    loading = true;
    allUsers = {await UsersApiCalls().getUserList()};
    loading = false;
    notifyListeners();
  }
}
