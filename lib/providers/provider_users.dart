import 'package:flutter/material.dart';
import '../entities/usuario.dart';
import '../services/service_user.dart';

class UserRequest extends ChangeNotifier {
  List<Usuario>? allUsers;
  bool loading = false;

  getDataUsers() async {
    loading = true;
    allUsers = (await UsersApiCalls().getUserList());
    loading = false;
    notifyListeners();
  }
}
