import 'package:flutter/material.dart';

import '../entities/event.dart';
import '../services/service_event.dart';

class EventsRequests extends ChangeNotifier {
  List<Event>? allEvents;
  bool loading = false;

  getData(String idUsuario) async {
    loading = true;
    allEvents = (await EventsApiCalls().getEventList(idUsuario));
    loading = false;
    notifyListeners();
  }
}
