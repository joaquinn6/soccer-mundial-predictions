import 'package:app_mundial/entities/event.dart';
import 'package:app_mundial/providers/provider_events.dart';
import 'package:app_mundial/providers/provider_users.dart';
import 'package:app_mundial/views/user_page.dart';
import 'package:app_mundial/views/users_points_pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/prediction_modal.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late UserRequest user;
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    final events = Provider.of<EventsRequests>(context, listen: false);
    user = Provider.of<UserRequest>(context, listen: false);
    events.getData(user.idLogged);
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventsRequests>(context);
    final user = Provider.of<UserRequest>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: Drawer(
          semanticLabel: 'Menu de opciones',
          child: Column(
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(),
                  child: Text(
                    user.userLogged,
                    style: const TextStyle(fontSize: 24),
                  )),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text('Tabla de posiciones'),
                    subtitle: const Text('Lista de amigos con sus puntos'),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TableUserPage()))
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Información'),
                    subtitle: const Text(
                        'Funcionamiento y reglamento de la aplicación'),
                    onTap: () => {print('Información')},
                  ),
                ],
              )),
              SizedBox(
                  height: 160,
                  child: ListView(
                    children: [
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Cerrar Sesión'),
                        onTap: () => {_logout()},
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete_sharp),
                        title: const Text('Eliminar cuenta'),
                        onTap: () => {deleteUser()},
                      )
                    ],
                  )),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Partidos'),
        ),
        body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final evento = events.allEvents![index];
              return InkWell(
                child: _cardEvent(evento),
                onTap: () =>
                    {events.selectEvent(index, evento), _showDialog(context)},
              );
            },
            itemCount: events.allEvents?.length ?? 0));
  }

  void deleteUser() {
    final Future<String> response = user.deleteUser();
    response.then((value) => {
          if (value == "OK")
            {_showToast("Usuario borrado correctamente", "success"), _logout()}
          else
            {
              Navigator.of(context, rootNavigator: true).pop(response),
              _showToast("Ha ocurrido un error al borrar usuario", "error")
            }
        });
  }

  _logout() {
    user.clearUserPreferences();
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
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

  _showDialog(BuildContext context) {
    const dialog = EventPrediction();
    showDialog(
        context: context,
        builder: (BuildContext context) => dialog,
        barrierDismissible: false);
  }

  Card _cardEvent(Event data) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Center(child: Text(data.versus)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _flagShow(data.isoLocal, data.nombreLocal),
            Text(_prediction('local', data)),
            Text(
              _marcador(data),
              style: const TextStyle(fontSize: 30),
            ),
            Text(_prediction('visita', data)),
            _flagShow(data.isoVisita, data.nombreVisita),
          ],
        ),
        Text(_formatDate(data.fecha))
      ]),
    ));
  }

  Widget _flagShow(String iso, String name) {
    if (iso != 'XX') {
      return CountryFlags.flag(
        iso,
        height: 60,
        width: 80,
        borderRadius: 8,
      );
    } else {
      return SizedBox(
        height: 60,
        width: 80,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: SvgPicture.asset(
            'assets/flags/$name.svg',
            semanticsLabel: 'bandera',
            fit: BoxFit.fill,
          ),
        ),
      );
    }
  }

  String _marcador(Event data) {
    String local = '-', visita = '-';
    if (data.golesLocal != null) local = data.golesLocal.toString();
    if (data.golesVisita != null) visita = data.golesVisita.toString();
    return local + '-'.toString() + visita;
  }

  String _formatDate(String hora) {
    return DateFormat('dd-MM-yyyy – hh:mm aa')
        .format(DateTime.parse(hora).toLocal());
  }

  String _prediction(String tipo, Event data) {
    if (data.prediction != null) {
      return tipo == 'local'
          ? data.prediction!.golesLocal.toString()
          : data.prediction!.golesVisita.toString();
    }
    return '';
  }
}
