import 'package:flutter/material.dart';

import '../entities/event.dart';
import '../entities/prediction.dart';
import '../models/response.dart';
import '../services/service_event.dart';
import '../services/service_prediction.dart';

class EventsRequests extends ChangeNotifier {
  List<Event>? allEvents;
  bool loading = false;
  Event? eventSelected;
  int indexEventSelected = 0;

  // ! prediction vars
  TextEditingController golLocal = TextEditingController(text: '');
  TextEditingController golVisita = TextEditingController(text: '');
  String errorSave = '';
  bool enabled = false;

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
    checkGoles();
    notifyListeners();
  }

  backEvent() {
    if (indexEventSelected - 1 >= 0) {
      indexEventSelected -= 1;
    } else {
      indexEventSelected = allEvents!.length - 1;
    }
    eventSelected = allEvents![indexEventSelected];
    checkGoles();
    notifyListeners();
  }

  Future<Response?> checkAndSave(String userId) async {
    Response? response;
    if (golLocal.text.isNotEmpty || golVisita.text.isNotEmpty) {
      int golesLocales = int.parse(golLocal.text == '' ? '0' : golLocal.text);
      int golesVisitantes =
          int.parse(golVisita.text == '' ? '0' : golVisita.text);

      if (eventSelected!.prediccion == null ||
          (eventSelected!.prediccion!.golesLocal != golesLocales ||
              eventSelected!.prediccion!.golesVisita != golesVisitantes)) {
        Prediction prediction = Prediction(
            eventId: eventSelected!.id,
            userId: userId,
            golesLocal: golesLocales,
            golesVisita: golesVisitantes);
        if (eventSelected!.prediccion != null) {
          prediction.id = eventSelected!.prediccion!.id;
          response = (await PredictionsApiCalls().putPrediction(prediction));
        } else {
          response = (await PredictionsApiCalls().postPrediction(prediction));
        }
        if (response!.prediction != null) {
          eventSelected!.prediccion = response.prediction;
          errorSave = '';
        } else {
          errorSave = 'Error al guardar predicción de ${eventSelected!.versus}';
        }
      }
    }
    notifyListeners();
    return response;
  }

  checkGoles() {
    if (eventSelected!.prediccion == null) {
      golLocal.text = '';
      golVisita.text = '';
    } else {
      golLocal.text = eventSelected!.prediccion!.golesLocal.toString();
      golVisita.text = eventSelected!.prediccion!.golesVisita.toString();
    }
    if (DateTime.parse(eventSelected!.fecha)
            .toLocal()
            .compareTo(DateTime.now().toLocal()) >
        0) {
      enabled = true;
    } else {
      enabled = false;
    }
  }

  selectEvent(int indice, Event event) {
    eventSelected = event;
    indexEventSelected = indice;
    checkGoles();
  }
}
