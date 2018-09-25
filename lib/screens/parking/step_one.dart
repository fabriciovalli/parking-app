import 'dart:async';

import 'package:app4car/colors.dart';
import 'package:app4car/models/controller_data.dart';
import 'package:app4car/screens/parking/parking_car.dart';
import 'package:app4car/utils/car_communication.dart';
import 'package:app4car/widgets/arc_stepper.dart';
import 'package:app4car/widgets/percent_indicator.dart';
import 'package:flutter/material.dart';

class ParkingStepOne extends StatefulWidget {
  final CarCommunication communicationController;

  const ParkingStepOne({Key key, this.communicationController}) : super(key: key);

  @override
  _ParkingStepOneState createState() => new _ParkingStepOneState();
}

class _ParkingStepOneState extends State<ParkingStepOne> with TickerProviderStateMixin {
  final flexTopCar = 1;
  final flexSpot = 3;
  final flexBottomCar = 2;

  final double paddingTop = 15.0;
  final double paddingBottom = 15.0;

  double carSpeed = 0.015;
  double sliderPercent;
  int stage;
  bool isMovingForward;

  AnimationController _controller;
  Animation _animation;

  AnimationController _opacityController;
  Animation _opacityAnimation;
  ControllerData _data;

  @override
  void initState() {
    super.initState();

    sliderPercent = 0.35;
    stage = 1;
    isMovingForward = true;

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 4))..addStatusListener(_animationHandler);

    _opacityController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addStatusListener(_opacityHandler);
    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _opacityController,
        curve: Interval(.5, 1.0, curve: Curves.easeOut),
      ),
    );

    widget.communicationController.addListener(_onMessageReceived);
  }

  _onMessageReceived(message) {
    ControllerData data = controllerDataFromJson(message);

    setState(() {
      _data = data;
      sliderPercent = double.parse(data.progresso) / 100;
      // stage = int.parse(_data.passo);
    });
  }

  void _opacityHandler(status) {
    if (status == AnimationStatus.completed) {
      _controller.forward();
    }
  }

  void _animationHandler(status) async {
    if (status == AnimationStatus.completed) {
      print("animation completed");
      await Future.delayed(Duration(milliseconds: 1500));
      _controller.reset();
      _controller.forward();
    }
  }

  Widget _builder(BuildContext context, BoxConstraints constraints) {
    final height = constraints.maxHeight;
    final width = constraints.maxWidth;
    final sliderY = height * (1.0 - .35);

    final Size parkingCarSize = Size(width / 3.2, height * 0.4);
    final Size parkingSpotSize = Size(width / 3.2, height * 0.4);

    double goalPosition = height * (flexTopCar + flexSpot / 2) * (1 / (flexTopCar + flexSpot + flexBottomCar));

    double sliderPosition = sliderY + parkingCarSize.height * 0.45;

    isMovingForward = (sliderPosition + carSpeed >= goalPosition);

    _animation = Tween(begin: height + parkingCarSize.height, end: goalPosition - parkingCarSize.height * .45).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));

    _opacityController.forward();

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
        left: width / 5,
        child: Opacity(
          opacity: _opacityAnimation.value,
          child: buildInfoText(),
        ),
      ),
      AnimatedBuilder(
        animation: _controller,
        child: ParkingCar(
          top: parkingCarSize.height + _animation.value,
          left: width / 4.2,
          width: parkingCarSize.width,
          isForward: isMovingForward,
        ),
        builder: (BuildContext context, Widget child) {
          return Transform(
            transform: Matrix4.translationValues(width / 4.2, _animation.value - parkingCarSize.height, 0.0),
            child: child,
          );
        },
      ),
      Positioned(
        right: 8.0,
        height: height,
        width: parkingCarSize.width,
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
              child: new Container(
                // height: parkingSpotSize.height,
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
      AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return _animation.value < parkingCarSize.height * 1.3 ? ArcStepper(stage) : Container();
        },
      ),
      Positioned(
        top: height * .75,
        child: AnimatedOpacity(
          opacity: sliderPercent == 1 ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Container(
            width: parkingCarSize.width * .8,
            child: ResultadoVaga(true),
          ),
        ),
      ),
    ];

    if (sliderPercent == 1) {
      // showOverlay();
    }

    return Stack(
      alignment: Alignment.center,
      children: stack,
    );
  }

  Widget buildInfoText() {
    return Container(
      width: 150.0,
      child: RichText(
        textAlign: TextAlign.left,
        text: new TextSpan(
          text: 'Passe pela vaga para o sensor medir se o seu carro cabe',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }

  showOverlay() async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8 / 3,
              child: ResultadoVaga(true),
            ),
          ),
    );

    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 2));
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: _builder,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _opacityController.dispose();
    widget.communicationController.removeListener(_onMessageReceived);
    super.dispose();
  }
}

class ResultadoVaga extends StatelessWidget {
  final bool fit;

  ResultadoVaga(this.fit);

  @override
  Widget build(BuildContext context) {
    return new RichText(
      textAlign: TextAlign.center,
      text: new TextSpan(
        text: 'Seu carro ',
        style: TextStyle(
          color: fit ? kApp4CarGreen : Colors.red,
          fontSize: 20.0,
        ),
        children: <TextSpan>[
          new TextSpan(text: fit ? 'cabe' : 'não cabe', style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(text: ' na vaga!'),
        ],
      ),
    );
  }
}
