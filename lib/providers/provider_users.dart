import 'package:flutter/material.dart';
import '../entities/usuario.dart';
import '../services/service_user.dart';

class UserRequest extends ChangeNotifier {
  UsersApiCalls UserRequestApi = UsersApiCalls();
  UserPreferences UserPreference = UserPreferences();
  List<Usuario> allUsers = [];
  bool loading = false;

  String amigoResponse = "";
  bool loadingAmigo = false;

  String idLogged = "";
  bool isLogged = false;

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

  checkLogin() async {
    idLogged = (await UserPreference.getUserId());
    if (idLogged.isEmpty) {
      isLogged = false;
    } else {
      isLogged = true;
    }
    notifyListeners();
  }
}
