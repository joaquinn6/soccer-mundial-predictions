class Prediction {
  String? id;
  String eventId;
  String userId;
  int golesLocal;
  int golesVisita;
  bool? penales;
  bool? tiemposExtra;

  Prediction(
      {this.id,
      required this.eventId,
      required this.userId,
      required this.golesLocal,
      required this.golesVisita,
      this.penales,
      this.tiemposExtra});

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'eventId': eventId,
      'userId': userId,
      'golesLocal': golesLocal,
      'golesVisita': golesVisita,
      'penales': penales,
      'tiemposExtra': tiemposExtra
    };
  }

  factory Prediction.fromJson(json) {
    return Prediction(
        id: json['_id'] as String,
        eventId: json['eventId'] as String,
        userId: json['userId'] as String,
        golesLocal: json['golesLocal'] as int,
        golesVisita: json['golesVisita'] as int,
        penales: json['penales'] as bool,
        tiemposExtra: json['tiemposExtra'] as bool);
  }
}
