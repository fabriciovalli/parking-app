import 'package:app4car/screens/parking/parking_car.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/widgets/arc_stepper.dart';
import 'package:app4car/widgets/bottom_appbar.dart';
import 'package:app4car/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class ParkingStepThree extends StatefulWidget {
  @override
  _ParkingStepThreeState createState() => new _ParkingStepThreeState();
}

class _ParkingStepThreeState extends State<ParkingStepThree> with TickerProviderStateMixin {
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
  Animation<double> _rotate;
  Animation<double> _left;
  Animation<double> _top;

  @override
  void initState() {
    super.initState();

    sliderPercent = 0.35;
    stage = 3;

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 4));
    _controller.forward();
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
      begin: goalPosition - parkingCarSize.height * .62,
      end: goalPosition - parkingCarSize.height * .4,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _rotate = Tween(begin: 32.0, end: .0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _left = Tween(begin: width - 1.65 * parkingSpotSize.width, end: width - parkingCarSize.width - 8).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

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
          left: _left.value,
          width: parkingCarSize.width,
        ),
        builder: (BuildContext context, Widget child) {
          return Positioned(
            left: _left.value,
            top: _top.value,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(-_rotate.value / 360),
              child: child,
            ),
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
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(-140.0, 10.0)
                    ..rotateZ(-2 * math.pi / 11),
                  child: new Container(
                    height: parkingSpotSize.height * .5,
                    width: parkingSpotSize.width,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey[400], width: 2.0), borderRadius: BorderRadius.circular(10.0)),
                  ),
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
    return LayoutBuilder(
      builder: _builder,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
