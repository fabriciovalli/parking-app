import 'package:app4car/colors.dart';
import 'package:flutter/material.dart';

class App4CarTheme {
  const App4CarTheme._(this.name, this.data);

  final String name;
  final ThemeData data;
}

final App4CarTheme kDark4CarTheme =
    new App4CarTheme._('Dark', _buildDarkTheme());
final App4CarTheme kLight4CarTheme =
    new App4CarTheme._('Light', _buildLightTheme());

TextTheme _buildTextTheme(TextTheme base, Color color) {
  return base.copyWith(
    headline: base.headline.copyWith(fontWeight: FontWeight.w500),
    title: base.title.copyWith(fontSize: 19.0),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
    subhead: base.subhead.copyWith(color: kApp4CarBlueBorder),
  ).apply(
    fontFamily: 'Rubik',
    displayColor: color,
    bodyColor: color,
  );
}

ThemeData _buildDarkTheme() {
  final ThemeData base = new ThemeData.dark();
  return base.copyWith(
    primaryColor: kApp4CarBlue,
    accentColor: kApp4CarBlueBorder,
    buttonColor: kApp4CarOrange,
    indicatorColor: Colors.white,
    canvasColor: Colors.white,//const Color(0xFF202124),
    scaffoldBackgroundColor: kApp4CarBlue,
    cardColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: base.iconTheme.copyWith(color: Colors.grey),
//    inputDecorationTheme: InputDecorationTheme(
//      labelStyle: TextStyle(color: kApp4CarBlueBorder, fontFamily: 'Roboto', fontSize: 16.0,),
//      border: UnderlineInputBorder(borderSide: BorderSide(color: kApp4CarBlueBorder)),
//      suffixStyle: TextStyle(color: kApp4CarBlueBorder, )
//    ),
    textTheme: _buildTextTheme(base.textTheme, Colors.white),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme, Colors.white),
    accentTextTheme: _buildTextTheme(base.accentTextTheme, Colors.white),
  );
}

ThemeData _buildLightTheme() {
  const Color primaryColor = const Color(0xFF0175c2);
  final ThemeData base = new ThemeData.light();
  return base.copyWith(
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: const Color(0xFF13B9FD),//#13b9fd
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: _buildTextTheme(base.textTheme, Colors.white),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme, Colors.white),
    accentTextTheme: _buildTextTheme(base.accentTextTheme, Colors.white),
  );
}
