class Event {
  String? id;
  int? idApi;

  Event({required this.id, this.idApi});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idApi': idApi,
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? "",
      idApi: json['idApi'] ?? "",
    );
  }
}
