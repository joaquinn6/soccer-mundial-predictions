import 'package:flutter/material.dart';

import '../entities/event.dart';
import '../services/service_event.dart';

class EventsRequests extends ChangeNotifier {
  List<Event>? getAll;
  bool loading = false;

  getData() async {
    loading = true;
    getAll = (await EventsApiCalls().getEventList())!;
    loading = false;
    notifyListeners();
  }
}
