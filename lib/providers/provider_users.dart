import 'package:app_mundial/models/response.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../entities/usuario.dart';
import '../services/service_user.dart';

class UserRequest extends ChangeNotifier {
  UsersApiCalls UserRequestApi = UsersApiCalls();
  UserPreferences UserPreference = UserPreferences();

  // ! Get table
  List<Usuario> allUsers = [];
  bool loading = false;

  // ! Put user
  String amigoResponse = "";
  bool loadingAmigo = false;

  // ! Shared Preferences
  String idLogged = "";
  bool isLogged = false;
  String userLogged = '';

  // ! post user
  bool isCreated = false;
  Response? responseUsuario;
  String errorPost = '';

  getDataUsers() async {
    loading = true;
    allUsers = (await UserRequestApi.getUserList(idLogged));
    loading = false;
    notifyListeners();
  }

  Future<String> addFriend(String username) async {
    loadingAmigo = true;
    amigoResponse = (await UserRequestApi.addUserFriend(username, idLogged));
    loadingAmigo = false;
    notifyListeners();
    return amigoResponse;
  }

  Future<String> deleteUser()async{
    var deleteResponse= (await UserRequestApi.deleteUser(idLogged));
    return deleteResponse;
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
  clearUserPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<Response?> register(String username, String email) async {
    isCreated = false;
    responseUsuario = (await UserRequestApi.createUser(username, email));
    if (responseUsuario!.usuario != null) {
      UserPreference.setUserId(responseUsuario!.usuario!.id);
      isLogged = true;
      idLogged = (responseUsuario!.usuario!.id);
      userLogged = responseUsuario!.usuario!.username;
      errorPost = '';
    } else if (responseUsuario!.error != null) {
      errorPost = responseUsuario!.error!;
    }
    notifyListeners();
    return responseUsuario;
  }
}
