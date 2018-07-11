import 'dart:math';

import 'package:app4car/colors.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/widgets/bottom_appbar.dart';
import 'package:app4car/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:app4car/screens/parking/step_one.dart';

class ParkingScreen extends StatefulWidget {
  @override
  _ParkingScreenState createState() => new _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen>
    with SingleTickerProviderStateMixin {
  double percentage = 0.0;

  @override
  void initState() {
    super.initState();
    percentage = 0.0;
  }

  Widget _buildParkedCars(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double appBarSize = 180.0;
    final double paddingTop = 16.0;

    final Size topCarSize = Size(screenSize.width / 3,
        (screenSize.height - appBarSize - paddingTop) * 0.4);
    topCarHeight = topCarSize.height;
    final Size parkingSpotSize = Size(screenSize.width / 3,
        (screenSize.height - appBarSize - paddingTop) * 0.45);
    final Size bottomCarSize = Size(screenSize.width / 3,
        (screenSize.height - appBarSize - paddingTop) * 0.15);

    return Container(
      width: topCarSize.width,
      padding: EdgeInsets.only(right: 8.0, bottom: 15.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: new Container(
              child: Image.asset(
                "assets/car-white.png",
                width: parkingSpotSize.width,
                fit: BoxFit.none,
                alignment: Alignment(0.0, 1.0),
              ),
            ),
          ),
          new SizedBox(
            height: 8.0,
          ),
          new Container(
            height: parkingSpotSize.height,
            decoration: BoxDecoration(
                border: Border.all(color: kApp4CarGreen, width: 2.0),
                borderRadius: BorderRadius.circular(8.0)),
          ),
          new SizedBox(
            height: 8.0,
          ),
          new Container(
            height: topCarSize.height,
            child: Image.asset("assets/car-white.png"),
          ),
        ],
      ),
    );
  }

  Widget _buildParkingCar(BuildContext context, double percentage) {
    final Size screenSize = MediaQuery.of(context).size;
    final double appBarSize = 180.0;
    final double paddingTop = 16.0;
    final Size parkingCar = Size(screenSize.width / 3,
        (screenSize.height - appBarSize - paddingTop) * 0.4);

    return Container(
      width: parkingCar.width * 1.35,
      padding: EdgeInsets.only(right: 10.0, bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            height: parkingCar.height,
            transform: Matrix4.translationValues(
                0.0, -parkingCar.height * percentage, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  'assets/forward.png',
                ),
                SizedBox(width: 10.0),
                Image.asset(
                  'assets/car-orange.png',
                ),
              ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CustomBottomAppBar bottomAppBar = new CustomBottomAppBar();
    return Scaffold(
      appBar: AppBar(
        title: Text(App4Car.appName),
        centerTitle: true,
        elevation: 5.0,
        automaticallyImplyLeading: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.menu),
          ),
        ],
      ),
      body: Row(
//        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SliderMarks(
                    markCount: 60,
                    color: Color(0x55FFFFFF),
                    paddingTop: 15.0,
                    paddingBottom: 15.0),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: _buildParkingCar(context, percentage),
          ),
          _buildParkedCars(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (percentage >= 1.15) {
              percentage = 0.0;
            } else {
              percentage = percentage + 0.01;
              print(percentage);
            }
          });
        },
        child: Icon(
          Icons.play_arrow,
        ),
        backgroundColor: Theme.of(context).buttonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomAppBar,
    );
  }
}
