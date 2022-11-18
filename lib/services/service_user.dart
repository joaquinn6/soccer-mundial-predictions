import '../models/response.dart';
import '../vars.dart';
import 'package:http/http.dart' as http;
import '../entities/usuario.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class UsersApiCalls {
  Future<List<Usuario>> getUserList(String userId) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    List<Usuario> result = [];
    try {
      final response = await http.get(
          Uri.parse("${Vars.baseUrl}user/$userId/table"),
          headers: headers);
      if (response.statusCode == 200) {
        final listaDinamica = json.decode(response.body) as List;
        result = listaDinamica
            .map((userJson) => Usuario.fromJson(userJson))
            .toList();
      } else {
        print("Error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  Future<String> addUserFriend(String username, String userId) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(<String, String>{'username': username});
    String result = "";
    try {
      final response = await http.put(
          Uri.parse("${Vars.baseUrl}user/$userId/amigo"),
          headers: headers,
          body: body);
      if (response.statusCode == 200) {
        result = "OK";
      } else {
        result = "KO";
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  Future<Response?> createUser(String username, String email) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body =
        jsonEncode(<String, String>{'username': username, 'email': email});
    Response? result = Response();
    try {
      final response = await http.post(Uri.parse("${Vars.baseUrl}user"),
          headers: headers, body: body);
      if (response.statusCode == 200) {
        result.usuario = Usuario.fromJson(json.decode(response.body));
      } else if (response.statusCode == 409) {
        result.error = 'Usuario ya existente';
      } else {
        result.error = 'Error de conexión';
      }
    } catch (e) {
      log(e.toString());
      result.error = 'Error de conexión';
      return result;
    }
    return result;
  }

  Future<String> deleteUser(String idLogged) async {
    var deleteUser = "";
    Map<String, String> headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.delete(
          Uri.parse("${Vars.baseUrl}user/$idLogged/delete"),
          headers: headers);
      if (response.statusCode == 200) {
        deleteUser = "OK";
      } else {
        deleteUser = "KO";
      }
    } catch (e) {
      log(e.toString());
      deleteUser = "KO";
      return deleteUser;
    }
    return deleteUser;
  }
}

class UserPreferences {
  Future<String> getUserId() async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString('userId') ?? '';
    return userId;
  }

  void setUserId(String userId) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('userId', userId);
  }

  Future<String> getUserName() async {
    final pref = await SharedPreferences.getInstance();
    final userName = pref.getString('userName') ?? '';
    return userName;
  }

  void setUserName(String userName) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('userName', userName);
  }
}
