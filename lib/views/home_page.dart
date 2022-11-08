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
        elevation: 2.0,
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 400, bottom: 20),
                child: Text(events.allEvents?[0].nombre ?? "HOLA"),
              )
            ],
          )),
    );
  }
}
