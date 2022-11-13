import '../vars.dart';
import 'package:http/http.dart' as http;
import '../entities/usuario.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class UsersApiCalls {
  Future<List<Usuario>> getUserList() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    List<Usuario> result = [];
    try {
      final response = await http.get(
          Uri.parse("${Vars.baseUrl}user/GjUhduqW2XnvMGuRFaRmu7/table"),
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

  Future<String> addUserFriend(String username) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(<String, String>{'username': username});
    String result = "";
    try {
      final response = await http.put(
          Uri.parse("${Vars.baseUrl}user/GjUhduqW2XnvMGuRFaRmu7/amigo"),
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
}
