class User {
  String id;
  String email;
  String username;
  int puntosResultado;
  int puntosMarcador;
  int total;
  List<String> amigos;
  String avatar;

  User(
      {required this.id,
      required this.email,
      required this.username,
      required this.puntosResultado,
      required this.puntosMarcador,
      required this.total,
      required this.amigos,
      required this.avatar});

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'username': username,
      'puntosResultado': puntosResultado,
      'puntosMarcador': puntosMarcador,
      'total': total,
      'amigos': amigos,
      'avatar': avatar
    };
  }

  factory User.fromJson(json) {
    return User(
        id: json['_id'] as String,
        email: json['email'] as String,
        username: json['username'] as String,
        puntosResultado: json['puntosResultado'] as int,
        puntosMarcador: json['puntosMarcador'] as int,
        total: json['total'] as int,
        amigos: json['amigos'] as List<String>,
        avatar: json['avatar'] as String);
  }
}
