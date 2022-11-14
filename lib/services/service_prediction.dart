import '../vars.dart';
import 'package:http/http.dart' as http;
import '../entities/prediction.dart';
import '../models/response.dart';
import 'dart:convert';
import 'dart:developer';

class PredictionsApiCalls {
  Future<Response?> postPrediction(Prediction prediction) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Response? result = Response();
    final body = jsonEncode(<String, dynamic>{
      'userId': prediction.userId,
      'eventId': prediction.eventId,
      'golesLocal': prediction.golesLocal,
      'golesVisita': prediction.golesVisita
    });
    try {
      final response = await http.post(Uri.parse('${Vars.baseUrl}prediction'),
          headers: headers, body: body);
      if (response.statusCode == 201) {
        result.prediction = Prediction.fromJson(json.decode(response.body));
      } else {
        result.error = "error";
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  Future<Response?> putPrediction(Prediction prediction) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Response? result = Response();
    final body = jsonEncode(<String, dynamic>{
      '_id': prediction.id,
      'userId': prediction.userId,
      'eventId': prediction.eventId,
      'golesLocal': prediction.golesLocal,
      'golesVisita': prediction.golesVisita
    });
    try {
      final response = await http.put(
          Uri.parse('${Vars.baseUrl}prediction/${prediction.id.toString()}'),
          headers: headers,
          body: prediction.toJson());
      if (response.statusCode == 200) {
        result.prediction = Prediction.fromJson(json.decode(response.body));
      } else {
        result.error = "error";
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
