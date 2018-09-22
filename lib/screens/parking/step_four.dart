import 'package:app4car/colors.dart';
import 'package:app4car/screens/parking/parking_car.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/widgets/arc_stepper.dart';
import 'package:app4car/widgets/bottom_appbar.dart';
import 'package:app4car/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class ParkingStepFour extends StatefulWidget {
  @override
  _ParkingStepFourState createState() => new _ParkingStepFourState();
}

class _ParkingStepFourState extends State<ParkingStepFour> with TickerProviderStateMixin {
  final flexTopCar = 3;
  final flexSpot = 3;
  final flexBottomCar = 1;

  final double paddingTop = 15.0;
  final double paddingBottom = 15.0;

  double carSpeed = 0.015;
  double sliderPercent;
  int stage;
  bool isMovingForward = false;

  AnimationController _controller;
  Animation<double> _top;

  @override
  void initState() {
    super.initState();

    sliderPercent = 0.35;
    stage = 4;

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  Widget _builder(BuildContext context, BoxConstraints constraints) {
    final height = constraints.maxHeight;
    final width = constraints.maxWidth;
    final sliderY = height * (1.0 - sliderPercent);

    final Size parkingCarSize = Size(width / 3.2, height * 0.4 - 20);
    final Size parkingSpotSize = Size(width / 3.2, height * 0.4 - 20);

    double goalPosition = height * (flexTopCar + flexSpot / 2) * (1 / (flexTopCar + flexSpot + flexBottomCar));
    double spotSize = height * (flexSpot / (flexTopCar + flexSpot + flexBottomCar));
    double sliderPosition = sliderY + parkingCarSize.height * 0.45;

    _top = Tween(
      begin: goalPosition - parkingCarSize.height * .4,
      end: goalPosition - parkingCarSize.height * .45,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    // _rotate = Tween(begin: 32.0, end: .0).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.linear,
    // ));

    // _left = Tween(begin: width / 4.5, end: parkingSpotSize.width / 10).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.linear,
    // ));

    List<Widget> stack = <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: SliderMarks(
              markCount: 80,
              color: Color(0x55FFFFFF),
              paddingTop: paddingTop,
              paddingBottom: paddingBottom,
              position: sliderPosition,
              goalMarkPosition: goalPosition, // 2.5,
              spotSize: spotSize, //0.4,
            ),
          )
        ],
      ),
      AnimatedBuilder(
        animation: _controller,
        child: ParkingCar(
          top: 0.0,
          left: width / 4.2,
          width: parkingCarSize.width,
        ),
        builder: (BuildContext context, Widget child) {
          return Positioned(
            left: width - parkingCarSize.width - 8,
            top: _top.value,
            child: child,
          );
        },
      ),
      Positioned(
        right: 8.0,
        height: height,
        width: parkingCarSize.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: flexTopCar,
                child: Image.asset(
                  "assets/car-white.png",
                  width: parkingCarSize.width,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment(0.0, 1.0),
                ),
              ),
              new SizedBox(
                height: 8.0,
              ),
              Expanded(
                flex: flexSpot,
                child: Container(
                  height: parkingSpotSize.height * .5,
                  width: parkingSpotSize.width,
                  decoration: BoxDecoration(border: Border.all(color: kApp4CarGreen, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              new SizedBox(
                height: 8.0,
              ),
              Expanded(
                flex: flexBottomCar,
                child: Image.asset(
                  "assets/car-white.png",
                  width: parkingCarSize.width,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment(0.0, -1.0),
                ),
              ),
            ],
          ),
        ),
      ),
      ArcStepper(stage),
    ];

    return Stack(
      alignment: Alignment.center,
      children: stack,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
      body: LayoutBuilder(
        builder: _builder,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.status == AnimationStatus.forward || _controller.status == AnimationStatus.completed) {
            _controller.reset();
          } else {
            _controller.forward();
          }
        },
        child: Icon(
          App4Car.driveIcon,
          color: Colors.white,
          size: 35.0,
        ),
        backgroundColor: Theme.of(context).buttonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
