import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      backgroundColor: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 4.0,
      child: SizedBox(
        height: 434,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: const SizedBox(
                      height: 30,
                      child: Icon(Icons.close),
                    ),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        final Future<Response?> res =
                            events.checkAndSave(user.idLogged);
                        res.then((value) => {
                              if (events.errorSave.isEmpty)
                                {Navigator.pop(context)}
                              else
                                {debugPrint(events.errorSave)}
                            });
                      }
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20.0)),
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
                  SizedBox(
                    height: 400.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Predicción',
                            style: TextStyle(fontSize: 20),
                          ),
                          Column(children: [
                            Text(events.eventSelected!.nombreLocal),
                            _flagShow(events.eventSelected!.isoLocal,
                                events.eventSelected!.nombreLocal),
                          ]),
                          Column(
                            children: [
                              SizedBox(
                                width: 85.0,
                                child: TextFormField(
                                  enabled: events.enabled,
                                  controller: events.golLocal,
                                  validator: (value) {
                                    if (value.toString().isNotEmpty &&
                                        int.tryParse(value.toString()) ==
                                            null) {
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                                        int.tryParse(value.toString()) ==
                                            null) {
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                          Column(children: [
                            _flagShow(events.eventSelected!.isoVisita,
                                events.eventSelected!.nombreVisita),
                            Text(events.eventSelected!.nombreVisita),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(20.0)),
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
            ],
          ),
        ),
      ),
    );
  }
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
