import 'dart:convert';

import 'package:app4car/models/car_data.dart';
import 'package:app4car/models/controller_data.dart';
import 'package:flutter/foundation.dart';
import 'websockets.dart';

class CarCommunication {
  // static final CarCommunication _controller = new CarCommunication._internal();

  ControllerData _data;

  CarCommunication() {
    sockets.initCommunication();
    sockets.addListener(_onMessageReceived);
  }

  // CarCommunication._internal() {
  //   sockets.initCommunication();
  //   sockets.addListener(_onMessageReceived);
  // }

  ControllerData get controllerData => _data;

  _onMessageReceived(message) {
    _listeners.forEach((Function callback) {
      callback(message);
    });
  }

  send(CarData carData) {
    print("will send car size");
    sockets.send(json.encode({
      "tamanho": "350",
    }));
  }

  begin() {
    print("will send begin");
    sockets.send(json.encode({
      "command": "begin",
    }));
  }

  nextStep(int stage) {
    print("will send nextStep");
    sockets.send(json.encode({
      "passo": stage.toString(),
      "command": "next",
    }));
  }

  ObserverList<Function> _listeners = new ObserverList<Function>();

  /// ---------------------------------------------------------
  /// Adds a callback to be invoked in case of incoming
  /// notification
  /// ---------------------------------------------------------
  addListener(Function callback) {
    _listeners.add(callback);
  }

  removeListener(Function callback) {
    _listeners.remove(callback);
  }
}
