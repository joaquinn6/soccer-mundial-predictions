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
      required this.estado});

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
        estado: json['estado'] as String);
  }
}
