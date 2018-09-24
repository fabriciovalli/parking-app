import 'dart:convert';

import 'package:app4car/models/car_data.dart';
import 'package:app4car/models/controller_data.dart';
import 'package:flutter/foundation.dart';
import 'websockets.dart';

CarCommunication controller = new CarCommunication();

class CarCommunication {
  // static final CarCommunication _controller = new CarCommunication._internal();

  ControllerData _data;

  CarCommunication() {
    sockets.initCommunication();
    sockets.addListener(_onMessageReceived);
  }

  CarCommunication._internal() {
    sockets.initCommunication();
    sockets.addListener(_onMessageReceived);
  }

  ControllerData get controllerData => _data;

  _onMessageReceived(message) {
    _listeners.forEach((Function callback) {
      callback(message);
    });
  }

  send(CarData carData) {
    sockets.send(json.encode({
      "data": "connection",
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
