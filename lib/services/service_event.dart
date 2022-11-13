import '../vars.dart';
import 'package:http/http.dart' as http;
import '../entities/event.dart';
import 'dart:convert';
import 'dart:developer';

class EventsApiCalls {
  Future<List<Event>?> getEventList(String idUsuario) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    List<Event>? result;
    try {
      final response = await http.get(
          Uri.parse('${Vars.baseUrl}events?user_id=$idUsuario'),
          headers: headers);
      if (response.statusCode == 200) {
        final listaDin = json
            .decode(const Utf8Decoder().convert(response.bodyBytes)) as List;
        result =
            listaDin.map((eventJson) => Event.fromJson(eventJson)).toList();
      } else {
        print("error");
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
