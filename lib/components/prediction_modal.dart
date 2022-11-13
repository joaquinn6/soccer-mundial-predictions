import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider_events.dart';
import '../providers/provider_users.dart';

class EventPrediction extends StatefulWidget {
  const EventPrediction({super.key});

  @override
  State<EventPrediction> createState() => _EventPredictionState();
}

class _EventPredictionState extends State<EventPrediction> {
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
    return Dialog(
      backgroundColor: const Color.fromARGB(134, 145, 142, 142),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4.0,
      child: SizedBox(
        height: 400.0,
        width: 400.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: const SizedBox(
                height: 400.0,
                width: 50,
                child: Center(child: Icon(Icons.arrow_back_ios)),
              ),
              onTap: () => {events.backEvent()},
            ),
            Container(
              height: 400.0,
              width: 200.0,
              color: Theme.of(context).canvasColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(children: [
                      Text(events.eventSelected!.equipoLocal),
                      CountryFlags.flag(
                        events.eventSelected!.isoLocal,
                        height: 60,
                        width: 80,
                        borderRadius: 8,
                      ),
                    ]),
                  ),
                  const Text('vs'),
                  Container(
                    child: Column(children: [
                      CountryFlags.flag(
                        events.eventSelected!.isoVisita,
                        height: 60,
                        width: 80,
                        borderRadius: 8,
                      ),
                      Text(events.eventSelected!.equipoVisita),
                    ]),
                  ),
                ],
              ),
            ),
            InkWell(
              child: const SizedBox(
                height: 400.0,
                width: 50,
                child: Center(child: Icon(Icons.arrow_forward_ios)),
              ),
              onTap: () => {events.nextEvent()},
            )
          ],
        ),
      ),
    );
  }
}
