import 'prediction.dart';

class Event {
  String id;
  String nombre;
  String equipoLocal;
  String equipoVisita;
  int ronda;
  String fecha;
  String liga;
  int? golesLocal;
  int? golesVisita;
  String? estadio;
  String estado;
  Prediction? prediction;
  String nombreLocal;
  String nombreVisita;
  String isoLocal;
  String isoVisita;
  String versus;
  Event(
      {required this.id,
      required this.nombre,
      required this.equipoLocal,
      required this.equipoVisita,
      required this.ronda,
      required this.fecha,
      required this.liga,
      this.golesLocal,
      this.golesVisita,
      this.estadio,
      required this.estado,
      this.prediction,
      required this.nombreLocal,
      required this.nombreVisita,
      required this.isoLocal,
      required this.isoVisita,
      required this.versus});

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nombre': nombre,
      'equipoLocal': equipoLocal,
      'equipoVisita': equipoVisita,
      'ronda': ronda,
      'fecha': fecha,
      'liga': liga,
      'golesLocal': golesLocal,
      'golesVisita': golesVisita,
      'estadio': estadio,
      'estado': estado,
      'prediction': prediction!.toJson(),
      'nombreLocal': nombreLocal,
      'nombreVisita': nombreVisita,
      'isoLocal': isoLocal,
      'isoVisita': isoVisita,
      'versus': versus,
    };
  }

  factory Event.fromJson(json) {
    return Event(
        id: json['_id'] as String,
        nombre: json['nombre'] as String,
        equipoLocal: json['equipoLocal'] as String,
        equipoVisita: json['equipoVisita'] as String,
        ronda: json['ronda'] as int,
        fecha: json['fecha'] as String,
        liga: json['liga'] as String,
        golesLocal: json['golesLocal'] as int?,
        golesVisita: json['golesVisita'] as int?,
        estadio: json['estadio'] as String?,
        estado: json['estado'] as String,
        prediction: json['prediction'] != null
            ? Prediction.fromJson(json['prediction'])
            : null,
        nombreLocal: json['nombreLocal'] as String,
        nombreVisita: json['nombreVisita'] as String,
        isoLocal: json['isoLocal'] as String,
        isoVisita: json['isoVisita'] as String,
        versus: json['versus'] as String);
  }
}
