import 'package:app_mundial/entities/event.dart';
import 'package:app_mundial/providers/provider_events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:intl/intl.dart';

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
    events.getData();
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventsRequests>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: Drawer(
          semanticLabel: 'Menu de opciones',
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                  decoration: BoxDecoration(),
                  child: Text(
                    'Opciones',
                    style: TextStyle(fontSize: 24),
                  )),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Lista de Amigos'),
                subtitle: const Text('Lista de amigos con sus puntos'),
                onTap: () => {},
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Información'),
                subtitle:
                    const Text('Funcionamiento y reglamento de la aplicación'),
                onTap: () => {print('Información')},
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Temporal'),
                subtitle: const Text('Login'),
                onTap: () => {Navigator.of(context).pushNamed('/username')},
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Events'),
        ),
        body: ListView.separated(
            separatorBuilder: ((context, index) => const Divider()),
            itemBuilder: (BuildContext context, int index) {
              final evento = events.allEvents![index];
              return InkWell(
                child: _cardEvent(evento),
                onTap: () => {print('tap in evento: ' + evento.nombre)},
              );
            },
            itemCount: events.allEvents?.length ?? 0));
  }
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
          CountryFlags.flag(
            data.isoLocal.toLowerCase(),
            height: 60,
            width: 80,
            borderRadius: 8,
          ),
          Text(
            _marcador(data),
            style: const TextStyle(fontSize: 30),
          ),
          CountryFlags.flag(
            data.isoVisita,
            height: 60,
            width: 80,
            borderRadius: 8,
          ),
        ],
      ),
      Text(_formatDate(data.fecha))
    ]),
  ));
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
