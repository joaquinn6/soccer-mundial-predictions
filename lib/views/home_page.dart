import 'package:app_mundial/entities/event.dart';
import 'package:app_mundial/providers/provider_events.dart';
import 'package:app_mundial/providers/provider_users.dart';
import 'package:app_mundial/views/users_points_pages.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    final events = Provider.of<EventsRequests>(context, listen: false);
    final user = Provider.of<UserRequest>(context, listen: false);

    events.getData(user.idLogged);
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventsRequests>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: Drawer(
          semanticLabel: 'Menu de opciones',
          child: Column(
            children: [
              const DrawerHeader(
                  decoration: BoxDecoration(),
                  child: Text(
                    'Opciones',
                    style: TextStyle(fontSize: 24),
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
              const Divider(),
              Container(
                  height: 100,
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text('Cerrar Sesión'),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TableUserPage()))
                        },
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
