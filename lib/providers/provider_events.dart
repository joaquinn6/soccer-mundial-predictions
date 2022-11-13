import 'package:flutter/material.dart';

import '../entities/event.dart';
import '../services/service_event.dart';

class EventsRequests extends ChangeNotifier {
  List<Event>? allEvents;
  bool loading = false;
  Event? eventSelected;
  int indexEventSelected = 0;

  getData(String idUsuario) async {
    loading = true;
    allEvents = (await EventsApiCalls().getEventList(idUsuario));
    loading = false;
    notifyListeners();
  }

  nextEvent() {
    if (indexEventSelected + 1 <= allEvents!.length - 1) {
      indexEventSelected += 1;
    } else {
      indexEventSelected = 0;
    }
    eventSelected = allEvents![indexEventSelected];
    notifyListeners();
  }

  backEvent() {
    if (indexEventSelected - 1 >= 0) {
      indexEventSelected -= 1;
    } else {
      indexEventSelected = allEvents!.length - 1;
    }
    eventSelected = allEvents![indexEventSelected];
    notifyListeners();
  }
}
