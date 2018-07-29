import 'package:app4car/colors.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/utils/app4car_navigator.dart';
import 'package:app4car/widgets/arc_stepper.dart';
import 'package:app4car/widgets/bottom_appbar.dart';
import 'package:app4car/widgets/slider.dart';
import 'package:flutter/material.dart';

class ParkingScreen extends StatefulWidget {
  @override
  _ParkingScreenState createState() => new _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen>
    with SingleTickerProviderStateMixin {
  double percentage = 0.0;
  int stage = 1;
  double finishXPosition;
  double finishYPosition;

  @override
  void initState() {
    super.initState();
    percentage = 0.0;
    stage = 1;
  }

  Widget _buildParkedCars() {
    final Size screenSize = MediaQuery.of(context).size;
    final double appBarSize = 180.0;
    final double paddingTop = 16.0;

    final Size topCarSize = Size(screenSize.width / 3,
        (screenSize.height - appBarSize - paddingTop) * 0.4);
    final Size parkingSpotSize = Size(screenSize.width / 3,
        (screenSize.height - appBarSize - paddingTop) * 0.45);
    final Size bottomCarSize = Size(screenSize.width / 3,
        (screenSize.height - appBarSize - paddingTop) * 0.15);

    finishYPosition =
        appBarSize + bottomCarSize.height + (parkingSpotSize.height / 2.0);

    return Container(
      width: topCarSize.width,
      padding: EdgeInsets.only(right: 8.0, bottom: 15.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              "assets/car-white.png",
              width: parkingSpotSize.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment(0.0, 1.0),
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
          Image.asset(
            "assets/car-white.png",
            height: topCarSize.height,
            fit: BoxFit.contain,
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
                    height: parkingCar.height,
                    fit: BoxFit.contain,
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
      body: Stack(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
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
              _buildParkedCars(),
            ],
          ),
          ArcStepper(stage),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          double newPercentage;
          if (percentage >= 1.15) {
            App4CarNavigator.goToParkingStepOne(context);
          } else {
            newPercentage = percentage + 0.03;
            print(newPercentage);
          }
          setState(() => percentage = newPercentage);
        },
        child: Icon(
          App4Car.driveIcon,
          color: Colors.white,
          size: 35.0,
        ),
        backgroundColor: Theme.of(context).buttonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomAppBar,
    );
  }
}
