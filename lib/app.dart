import 'package:app4car/screens/home.dart';
import 'package:app4car/screens/login.dart';
import 'package:app4car/screens/parking.dart';
import 'package:app4car/screens/parking/step_four.dart';
import 'package:app4car/screens/parking/step_one.dart';
import 'package:app4car/screens/parking/step_three.dart';
import 'package:app4car/screens/parking/step_two.dart';
import 'package:app4car/screens/parking_steps.dart';
import 'package:flutter/material.dart';
import 'themes.dart';

class App4CarApp extends StatefulWidget {
  const App4CarApp({
    Key key,
  }) : super(key: key);

  @override
  _App4CarAppState createState() => new _App4CarAppState();
}

class _App4CarAppState extends State<App4CarApp> {
  var _buildRoutes = <String, WidgetBuilder>{
    // "/intro": (BuildContext context) => IntroScreen(),
    "/login": (BuildContext context) => LoginScreen(),
    "/home": (BuildContext context) => HomeScreen(),
    "/park": (BuildContext context) => ParkingSteps(),
    "/stepOne": (BuildContext context) => ParkingStepOne(),
    "/stepTwo": (BuildContext context) => ParkingStepTwo(),
    "/stepThree": (BuildContext context) => ParkingStepThree(),
    "/stepFour": (BuildContext context) => ParkingStepFour(),
    "/slider": (BuildContext context) => ParkingScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: kDark4CarTheme.data,
      debugShowCheckedModeBanner: false,
      routes: _buildRoutes,
      home: LoginScreen(),
    );
  }
}
