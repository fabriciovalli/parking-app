import 'package:app4car/colors.dart';
import 'package:app4car/models/controller_data.dart';
import 'package:app4car/screens/parking/parking_car.dart';
import 'package:app4car/utils/car_communication.dart';
import 'package:app4car/widgets/arc_stepper.dart';
import 'package:app4car/widgets/percent_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class ParkingStepFour extends StatefulWidget {
  final CarCommunication communicationController;

  const ParkingStepFour({Key key, this.communicationController}) : super(key: key);

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

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..addStatusListener(_animationHandler);
    _controller.repeat();
    widget.communicationController.addListener(_onMessageReceived);
  }

  void _animationHandler(status) async {
    if (status == AnimationStatus.completed) {
      if (sliderPercent == 1.0) {
        print("parking completed - going to the next step");
        _controller.stop();
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

    double goalPosition = height * (flexTopCar + flexSpot / 2) * (1 / (flexTopCar + flexSpot + flexBottomCar));

    _top = Tween(
      begin: goalPosition - parkingCarSize.height * .4,
      end: goalPosition - parkingCarSize.height * .45,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
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
        top: height * .15,
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

  Widget buildInfoText() {
    return Container(
      width: 130.0,
      child: RichText(
        textAlign: TextAlign.right,
        text: new TextSpan(
          text: 'Centralize\n o carro na\n vaga',
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
