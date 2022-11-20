import 'package:app_mundial/providers/provider_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../entities/usuario.dart';

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
    return Semantics(
      label: "Tabla de posiciones",
      child: Scaffold(
          appBar: AppBar(
              title: const Text('Tabla de posiciones'),
              actions: <Widget>[
                IconButton(
                    tooltip: 'Agregar amigo',
                    icon: const Icon(Icons.person_add),
                    onPressed: () {
                      openDialog(users);
                    }),
              ]),
          body: InteractiveViewer(
            constrained: false,
            child: Semantics(
              readOnly: true,
              child: DataTable(
                checkboxHorizontalMargin: 8.0,
                columnSpacing: 8,
                dividerThickness: 1,
                columns: const <DataColumn>[
                  DataColumn(numeric: true, label: Expanded(child: Text("#"))),
                  DataColumn(label: Expanded(child: Text("Nombre"))),
                  DataColumn(
                      numeric: true, label: Expanded(child: Text("Total"))),
                  DataColumn(
                      numeric: true, label: Expanded(child: Text("Resultado"))),
                  DataColumn(
                      numeric: true, label: Expanded(child: Text("Marcador"))),
                ],
                rows: _listsRows(users.allUsers),
              ),
            ),
          )),
    );
  }

  Future<String?> openDialog(users) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).canvasColor,
            title: const Text('Agregar amigo'),
            content: TextField(
              decoration: const InputDecoration(
                  hintText: 'Ingresa el nombre de usuario'),
              controller: amigoEditText,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    cerrarDialogo("");
                  },
                  child: const Text('Cancelar')),
              TextButton(
                  style:
                      TextButton.styleFrom(foregroundColor: Colors.lightBlue),
                  onPressed: () {
                    agregarAmigo();
                  },
                  child: const Text('Agregar')),
            ],
          ));
  Future<void> agregarAmigo() async {
    final Future<String> responseAdd =
        usersProvider.addFriend(amigoEditText.text);
    responseAdd.then((response) => {
          if (response == "OK")
            {
              usersProvider.getDataUsers(),
              amigoEditText.text = "",
              _showToast("Amigo agregado", "success")
            }
          else
            {
              amigoEditText.text = "",
              _showToast("Hubo un error con el nombre de usuario", "error")
            }
        });
    cerrarDialogo(usersProvider.amigoResponse);
  }

  void cerrarDialogo(String response) {
    amigoEditText.text = "";
    Navigator.of(context, rootNavigator: true).pop(response);
  }

  _showToast(String msg, String tipo) {
    Color color;
    IconData icono;
    if (tipo == "error") {
      color = Color.fromARGB(151, 231, 20, 20);
      icono = Icons.error;
    } else if (tipo == "success") {
      color = Colors.greenAccent;
      icono = Icons.check;
    } else {
      color = Color.fromARGB(136, 226, 241, 14);
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

List<DataRow> _listsRows(List<Usuario> usuarios) {
  List<DataRow> rows = [];
  int index = 0;
  for (var user in usuarios) {
    DataRow row = DataRow(cells: [
      DataCell(Text(
        (index + 1).toString(),
      )),
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
    ]);
    rows.add(row);
    index++;
  }
  return rows;
}
