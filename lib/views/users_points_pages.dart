import 'package:app_mundial/providers/provider_users.dart';
import 'package:app_mundial/services/service_user.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TableUserPage extends StatefulWidget {
  const TableUserPage({super.key});

  @override
  State<TableUserPage> createState() => _TableUserPageState();
}

class _TableUserPageState extends State<TableUserPage> {
  final amigoEditText = TextEditingController();
  late UserRequest usersProvider;
  late FToast fToast;

  @override
  void initState() {
    usersProvider = Provider.of<UserRequest>(context, listen: false);
    super.initState();
    usersProvider.getDataUsers();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    amigoEditText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserRequest>(context);
    return Scaffold(
        appBar:
            AppBar(title: const Text('Tabla de posiciones'), actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () {
                openDialog(users);
              }),
        ]),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DataTable(
                checkboxHorizontalMargin: 8.0,
                columnSpacing: 8,
                dividerThickness: 2,
                columns: const <DataColumn>[
                  DataColumn(label: Expanded(child: Text("Avatar"))),
                  DataColumn(label: Expanded(child: Text("Nombre"))),
                  DataColumn(label: Expanded(child: Text("Puntos"))),
                  DataColumn(label: Expanded(child: Text("Pts. Resultado"))),
                  DataColumn(label: Expanded(child: Text("Pts. Marcador"))),
                ],
                rows: users.allUsers
                    .map((user) => DataRow(cells: [
                          DataCell(
                            CountryFlags.flag(
                              user.avatar.toLowerCase(),
                              height: 25,
                              width: 25,
                              borderRadius: 100,
                            ),
                          ),
                          DataCell(Text(
                            user.username,
                          )),
                          DataCell(
                            Text(
                              user.total.toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              user.puntosResultado.toString(),
                            ),
                          ),
                          DataCell(
                            Text(
                              user.puntosMarcador.toString(),
                            ),
                          ),
                        ]))
                    .toList())
          ],
        ));
  }

  Future<String?> openDialog(users) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Agregar amigo'),
            content: TextField(
              decoration: const InputDecoration(
                  hintText: 'Ingresa el codigo de usuario'),
              controller: amigoEditText,
            ),
            actions: [
              TextButton(
                  style:
                      TextButton.styleFrom(foregroundColor: Colors.lightBlue),
                  onPressed: () {
                    agregarAmigo(users);
                  },
                  child: const Text('Agregar')),
              TextButton(
                  onPressed: () {
                    cerrarDialogo("");
                  },
                  child: const Text('Cancelar'))
            ],
          ));
  Future<void> agregarAmigo(users) async {
    UsersApiCalls apiuser = UsersApiCalls();
    String response = await apiuser.addUserFriend(amigoEditText.text);
    usersProvider.addFriend(amigoEditText.text);
    if (response == "OK") {
      usersProvider.getDataUsers();
      amigoEditText.text = "";
      _showToast("Amigo agregado", "success");
    } else {
      amigoEditText.text = "";
      _showToast("Hubo un error con el nombre de usuario", "error");
    }
    cerrarDialogo(users.amigoResponse);
  }

  void cerrarDialogo(String response) {
    amigoEditText.text = "";
    Navigator.of(context, rootNavigator: true).pop(response);
  }

  _showToast(String msg, String tipo) {
    Color color;
    IconData icono;
    if (tipo == "error") {
      color = const Color.fromARGB(255, 231, 20, 20);
      icono = Icons.error;
    } else if (tipo == "success") {
      color = Colors.greenAccent;
      icono = Icons.check;
    } else {
      color = const Color.fromARGB(255, 226, 241, 14);
      icono = Icons.warning;
    }
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(style: const TextStyle(color: Colors.black), msg),
          )
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
