import 'package:app4car/colors.dart';
import 'package:flutter/material.dart';

final double width = 100.0;
double topCarHeight = 0.0;

Widget _buildParkedCars(BuildContext context) {
  final Size screenSize = MediaQuery.of(context).size;
  final double appBarSize = 180.0;
  final double paddingTop = 16.0;

  final Size topCarSize = Size(screenSize.width / 3, (screenSize.height - appBarSize - paddingTop) * 0.4);
  topCarHeight = topCarSize.height;
  final Size parkingSpotSize = Size(screenSize.width / 3, (screenSize.height - appBarSize - paddingTop) * 0.45);
  final Size bottomCarSize = Size(screenSize.width / 3, (screenSize.height - appBarSize - paddingTop) * 0.15);

  return Container(
    width: topCarSize.width,
    padding: EdgeInsets.only(right: 8.0, top: 40.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Container(
          height: topCarSize.height,
          decoration: BoxDecoration(
              border: Border.all(color: kApp4CarBlueBorder, width: 2.0)
          ),
          child: Image.asset("assets/car-white.png"),
        ),
        new SizedBox(height: 8.0,),
        new Container(
          height: parkingSpotSize.height,
          decoration: BoxDecoration(
              border: Border.all(color: kApp4CarGreen, width: 2.0),
              borderRadius: BorderRadius.circular(8.0)
          ),
        ),
        new SizedBox(height: 8.0,),

        Expanded(
          child: new Container(
            decoration: BoxDecoration(
                border: Border.all(color: kApp4CarBlueBorder, width: 2.0)
            ),
            child: Image.asset("assets/car-white.png", width: parkingSpotSize.width, fit: BoxFit.none, alignment: Alignment(0.0, -1.0),),
          ),
        ),
      ],
    ),
  );
}

Widget _buildParkingCar(BuildContext context) {
  final Size screenSize = MediaQuery.of(context).size;
  final double appBarSize = 180.0;
  final double paddingTop = 16.0;
  final Size parkingCar = Size(screenSize.width / 3, (screenSize.height - appBarSize - paddingTop) * 0.4);

  return Container(
    width: parkingCar.width,
    padding: EdgeInsets.only(left: 10.0, top: 40.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: parkingCar.height,
          child: Stack(
              children: <Widget>[
                Image.asset('assets/car-orange.png',),
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: FractionalTranslation(
                      translation: const Offset(0.13, 0.7),
                      child: Image.asset('assets/wheel-right.png',)
                  ),
                ),
              ]
          ),
        ),
      ],
    ),
  );
}