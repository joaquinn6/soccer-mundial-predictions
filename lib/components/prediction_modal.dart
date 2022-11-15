import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/response.dart';
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
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final events = Provider.of<EventsRequests>(context);
    final user = Provider.of<UserRequest>(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 4.0,
      child: SizedBox(
        height: 400.0,
        child: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: const SizedBox(
                  height: 400.0,
                  width: 50,
                  child: Center(child: Icon(Icons.arrow_back_ios)),
                ),
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    final Future<Response?> res =
                        events.checkAndSave(user.idLogged);
                    res.then((value) => {
                          if (events.errorSave.isEmpty)
                            {events.backEvent()}
                          else
                            {debugPrint(events.errorSave)}
                        });
                  }
                },
              ),
              Container(
                height: 400.0,
                color: Theme.of(context).canvasColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(children: [
                            Text(events.eventSelected!.nombreLocal),
                            CountryFlags.flag(
                              events.eventSelected!.isoLocal,
                              height: 60,
                              width: 80,
                              borderRadius: 8,
                            ),
                          ]),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 85.0,
                              child: TextFormField(
                                enabled: events.enabled,
                                controller: events.golLocal,
                                validator: (value) {
                                  if (value.toString().isNotEmpty &&
                                      int.tryParse(value.toString()) == null) {
                                    return 'No Decimal';
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: false, signed: false),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).dividerColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 2.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color: Theme.of(context).errorColor,
                                          width: 2.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color: Theme.of(context).errorColor,
                                          width: 2.0),
                                    )),
                              ),
                            ),
                            Text(
                              '-',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(
                              width: 85.0,
                              child: TextFormField(
                                enabled: events.enabled,
                                controller: events.golVisita,
                                validator: (value) {
                                  if (value.toString().isNotEmpty &&
                                      int.tryParse(value.toString()) == null) {
                                    return 'No decimal';
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: false, signed: false),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).dividerColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 2.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color: Theme.of(context).errorColor,
                                          width: 2.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color: Theme.of(context).errorColor,
                                          width: 2.0),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Column(children: [
                            CountryFlags.flag(
                              events.eventSelected!.isoVisita,
                              height: 60,
                              width: 80,
                              borderRadius: 8,
                            ),
                            Text(events.eventSelected!.nombreVisita),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                child: const SizedBox(
                  height: 400.0,
                  width: 50,
                  child: Center(child: Icon(Icons.arrow_forward_ios)),
                ),
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    final Future<Response?> res =
                        events.checkAndSave(user.idLogged);
                    res.then((value) => {
                          if (events.errorSave.isEmpty)
                            {events.nextEvent()}
                          else
                            {debugPrint(events.errorSave)}
                        });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
