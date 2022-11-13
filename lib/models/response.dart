import 'package:app_mundial/entities/prediction.dart';
import 'package:app_mundial/entities/usuario.dart';

import '../entities/event.dart';

class Response {
  String? error;
  Usuario? usuario;
  Event? event;
  Prediction? prediction;

  Response({this.error, this.usuario, this.event, this.prediction});

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'usuario': Usuario,
      'event': event,
      'prediction': prediction,
    };
  }

  factory Response.fromJson(json) {
    return Response(
        error: json['error'] as String?,
        usuario: json['usuario'] as Usuario?,
        event: json['event'] as Event?,
        prediction: json['prediction'] as Prediction?);
  }
}
