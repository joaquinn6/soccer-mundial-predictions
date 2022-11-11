import 'package:app_mundial/providers/provider_users.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableUserPage extends StatefulWidget {
  const TableUserPage({super.key});

  @override
  State<TableUserPage> createState() => _TableUserPageState();
}

class _TableUserPageState extends State<TableUserPage> {
  final amigoEditText = TextEditingController();
  @override
  void initState() {
    final usersProvider = Provider.of<UserRequest>(context, listen: false);
    super.initState();
    usersProvider.getDataUsers();
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
              icon: new Icon(Icons.person_add),
              onPressed: () {
                openDialog(users);
              }),
        ]),
        body: DataTable(
            checkboxHorizontalMargin: 8.0,
            dividerThickness: 2,
            columns: const <DataColumn>[
              DataColumn(label: Expanded(child: Text(""))),
              DataColumn(label: Expanded(child: Text("Nombre"))),
              DataColumn(label: Expanded(child: Text("Puntos"))),
              DataColumn(label: Expanded(child: Text("Pts. Resultado"))),
              DataColumn(label: Expanded(child: Text("Pts. Marcador"))),
            ],
            rows: users.allUsers!
                .map((user) => DataRow(cells: [
                      DataCell(CountryFlags.flag(
                        user.avatar.toLowerCase(),
                        height: 30,
                        width: 40,
                        borderRadius: 8,
                      )),
                      DataCell(
                        Text(
                          user.username,
                        ),
                      ),
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
                .toList()));
  }

  Future<String?> openDialog(users) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Agregar amigo'),
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
              TextButton(onPressed: () {}, child: const Text('Cancelar'))
            ],
          ));
  void agregarAmigo(users) {
    users.addFriend(amigoEditText.text);
    print(users.amigoResponse);
  }
}
/*
List<DataRow> _DataRowUsers(users) {
  List<DataRow> lista = [];
  if (users != null) {
    lista = users!
        .map((user) => DataRow(cells: [
              DataCell(
                Text(
                  user.username,
                ),
              ),
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
        .toList();
  }
  return lista;
}
 */

/* for (var item in users.allUsers!)
              DataRow(cells: <DataCell>[
                DataCell(Text(item.username)),
                DataCell(Text(item.total.toString())),
                DataCell(Text(item.puntosResultado.toString())),
                DataCell(Text(item.puntosMarcador.toString())),
              ]) */