import 'package:app_mundial/entities/event.dart';
import 'package:app_mundial/providers/provider_events.dart';
import 'package:app_mundial/views/users_points_pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TableUserPage()))
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Información'),
                subtitle:
                    const Text('Funcionamiento y reglamento de la aplicación'),
                onTap: () => {print('Información')},
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
              return Card(
                  child: ListTile(
                title: Text(evento.nombre),
                subtitle:
                    Text(evento.estadio! + " - ".toString() + evento.fecha),
                onTap: (() => {print('Toque en '.toString() + evento.id)}),
              ));
            },
            itemCount: events.allEvents?.length ?? 0));
  }
}
