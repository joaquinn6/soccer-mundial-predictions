import 'package:app_mundial/entities/user.dart';

import '../vars.dart';
import 'package:http/http.dart' as http;
import '../entities/event.dart';
import 'dart:convert';
import 'dart:developer';

class UsersApiCalls {
  Future<List<User>?> getUserList() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    List<User>? result;
    try {
      final response = await http.get(
          Uri.parse(Vars.baseUrl + "user/GjUhduqW2XnvMGuRFaRmu7/table"),
          headers: headers);
      if (response.statusCode == 200) {}
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
