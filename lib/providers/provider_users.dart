import 'package:flutter/material.dart';
import '../entities/usuario.dart';
import '../services/service_user.dart';

class UserRequest extends ChangeNotifier {
  UsersApiCalls UserRequestApi = UsersApiCalls();
  List<Usuario> allUsers = [];
  bool loading = false;

  String amigoResponse = "";
  bool loadingAmigo = false;

  getDataUsers() async {
    loading = true;
    allUsers = (await UserRequestApi.getUserList());
    loading = false;
    notifyListeners();
  }

  addFriend(String username) async {
    loadingAmigo = true;
    amigoResponse = (await UserRequestApi.addUserFriend(username));
    loadingAmigo = false;
    notifyListeners();
  }
}
