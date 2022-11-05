import '../vars.dart';
import 'package:http/http.dart' as http;
import '../entities/event.dart';
import 'dart:convert';
import 'dart:developer';

class EventsApiCalls {
  Future<List<Event>?> getEventList() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    List<Event>? result;
    try {
      final response =
          await http.get(Uri.parse(Vars.baseUrl + ''), headers: headers);
      if (response.statusCode == 200) {
        result = json.decode(response.body);
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
