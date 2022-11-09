import 'package:app_mundial/providers/provider_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableUserPage extends StatefulWidget {
  const TableUserPage({super.key});

  @override
  State<TableUserPage> createState() => _TableUserPageState();
}

class _TableUserPageState extends State<TableUserPage> {
  @override
  void initState() {
    super.initState();
    final users = Provider.of<UserRequest>(context, listen: false);
    users.getDataUsers();
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserRequest>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Tabla de posiciones'),
        ),
        body: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Expanded(child: Text("Nombre"))),
              DataColumn(label: Expanded(child: Text("Puntos"))),
              DataColumn(label: Expanded(child: Text("Pts. Resultado"))),
              DataColumn(label: Expanded(child: Text("Pts. Marcador"))),
            ],
            rows: users.allUsers!
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
                .toList()));
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