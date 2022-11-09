import 'package:app_mundial/entities/event.dart';
import 'package:app_mundial/providers/provider_events.dart';
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
              ));
            },
            itemCount: events.allEvents?.length ?? 0));
  }
}
