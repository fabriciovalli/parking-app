import 'dart:async';

import 'package:app4car/colors.dart';
import 'package:app4car/models/controller_data.dart';
import 'package:app4car/screens/parking/parking_car.dart';
import 'package:app4car/utils/car_communication.dart';
import 'package:app4car/widgets/arc_stepper.dart';
import 'package:app4car/widgets/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class ParkingStepThree extends StatefulWidget {
  final CarCommunication communicationController;

  const ParkingStepThree({Key key, this.communicationController})
      : super(key: key);

  @override
  _ParkingStepThreeState createState() => new _ParkingStepThreeState();
}

class _ParkingStepThreeState extends State<ParkingStepThree>
    with TickerProviderStateMixin {
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

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..addStatusListener(_animationHandler);
    _controller.forward();
    widget.communicationController.addListener(_onMessageReceived);
  }

  void _animationHandler(status) async {
    if (status == AnimationStatus.completed) {
      if (sliderPercent == 1.0) {
        print("step 3 completed - going to the next step");
        _controller.stop();
        widget.communicationController.nextStep(stage);
      } else {
        _controller.reset();
        _controller.forward();
      }
    }
  }

  _onMessageReceived(message) {
    ControllerData data = controllerDataFromJson(message);
    setState(() {
      // _data = data;
      sliderPercent = double.parse(data.progresso) / 100;
      // stage = int.parse(_data.passo);
    });
  }

  Widget _builder(BuildContext context, BoxConstraints constraints) {
    final height = constraints.maxHeight;
    final width = constraints.maxWidth;

    final Size parkingCarSize = Size(width / 3.2, height * 0.4 - 20);
    final Size parkingSpotSize = Size(width / 3.2, height * 0.4 - 20);

    double goalPosition = height *
        (flexTopCar + flexSpot / 2) *
        (1 / (flexTopCar + flexSpot + flexBottomCar));

    _top = Tween(
      begin: goalPosition - parkingCarSize.height * .62,
      end: goalPosition - parkingCarSize.height * .4,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.2, .65, curve: Curves.linear),
    ));

    _rotate = Tween(begin: 32.0, end: .0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.2, .65, curve: Curves.linear),
    ));

    _left = Tween(
            begin: width - 2 * parkingSpotSize.width,
            end: width - 1.35 * parkingCarSize.width - 8)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.2, .65, curve: Curves.linear),
    ));

    List<Widget> stack = <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: LinearPercentIndicator(
              height: height * .8,
              lineWidth: 40.0,
              percent: sliderPercent,
              linearStrokeCap: LinearStrokeCap.butt,
              progressColor: kApp4CarGreen,
            ),
          )
        ],
      ),
      Positioned(
        top: height * .1,
        left: width / 3.2,
        child: Opacity(
          opacity: 1.0, //_opacityAnimation.value,
          child: buildInfoText(),
        ),
      ),
      AnimatedBuilder(
        animation: _controller,
        child: ParkingCar(
          top: 0.0,
          left: _left.value,
          width: parkingCarSize.width,
          isForward: false,
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
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400], width: 2.0),
                        borderRadius: BorderRadius.circular(10.0)),
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

  Widget buildInfoText() {
    return Container(
      width: 130.0,
      child: RichText(
        textAlign: TextAlign.right,
        text: new TextSpan(
          text: 'Vire todo\n o volante\n para a\n esquerda\n e dê ré',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
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
    widget.communicationController.removeListener(_onMessageReceived);
    super.dispose();
  }
}
