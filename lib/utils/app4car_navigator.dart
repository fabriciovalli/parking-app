import 'package:flutter/material.dart';

class App4CarNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }

  static void goToIntro(BuildContext context) {
    Navigator.pushNamed(context, "/intro");
  }

  static void goToParking(BuildContext context) {
    Navigator.pushNamed(context, "/park");
  }

  static void goToParkingStepOne(BuildContext context) {
    Navigator.pushNamed(context, "/stepOne");
  }
}