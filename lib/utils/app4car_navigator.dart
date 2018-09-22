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

  static void goToParkingStepTwo(BuildContext context) {
    Navigator.pushNamed(context, "/stepTwo");
  }

  static void goToParkingStepThree(BuildContext context) {
    Navigator.pushNamed(context, "/stepThree");
  }

  static void goToParkingStepFour(BuildContext context) {
    Navigator.pushNamed(context, "/stepFour");
  }

  static void goToParkingSlider(BuildContext context) {
    Navigator.pushNamed(context, "/slider");
  }
}
