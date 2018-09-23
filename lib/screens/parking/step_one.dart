import 'package:app4car/colors.dart';
import 'package:app4car/models/controller_data.dart';
import 'package:app4car/screens/parking/parking_car.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/utils/car_communication.dart';
import 'package:app4car/widgets/arc_stepper.dart';
import 'package:app4car/widgets/bottom_appbar.dart';
import 'package:app4car/widgets/percent_indicator.dart';
import 'package:app4car/widgets/slider.dart';
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
  ControllerData _data;

  @override
  void initState() {
    super.initState();

    sliderPercent = 0.35;
    stage = 1;
    isMovingForward = true;

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 4));
    _controller.repeat();

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

  Widget _builder(BuildContext context, BoxConstraints constraints) {
    final height = constraints.maxHeight;
    final width = constraints.maxWidth;
    final sliderY = height * (1.0 - sliderPercent);

    final Size parkingCarSize = Size(width / 3.2, height * 0.4);
    final Size parkingSpotSize = Size(width / 3.2, height * 0.4);

    double goalPosition = height * (flexTopCar + flexSpot / 2) * (1 / (flexTopCar + flexSpot + flexBottomCar));

    double spotSize = height * (flexSpot / (flexTopCar + flexSpot + flexBottomCar));

    double sliderPosition = sliderY + parkingCarSize.height * 0.45;

    isMovingForward = (sliderPosition + carSpeed >= goalPosition);

    _animation = Tween(begin: sliderY + parkingCarSize.height, end: goalPosition - parkingCarSize.height * .45).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
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
            // child: SliderMarks(
            //   markCount: 80,
            //   color: Color(0x55FFFFFF),
            //   paddingTop: paddingTop,
            //   paddingBottom: paddingBottom,
            //   position: sliderPosition,
            //   goalMarkPosition: goalPosition, // 2.5,
            //   spotSize: spotSize, //0.4,
            // ),
          )
        ],
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
          }),
      //OVERLAY
      // AnimatedBuilder(
      //   animation: _controller,
      //   builder: (BuildContext context, Widget child) {
      //     return Transform(
      //       transform: Matrix4.translationValues(0.0,
      //           -height + _animation.value - parkingCarSize.height * .4, 0.0),
      //       child: Container(
      //         color: Colors.black87,
      //         height: height,
      //         // height: height + _animation.value,
      //       ),
      //     );
      //   },
      // ),
    ];

    if (sliderPosition < goalPosition && sliderPosition + height * (1.0 - carSpeed) > goalPosition) {
      stage = 2;
      stack.add(
        Positioned(
          top: height * 0.75,
          child: Container(
            width: parkingCarSize.width * 0.8,
            child: ResultadoVaga(true),
          ),
        ),
      );
    }

    if (sliderPercent > 0.5) {
      stack.add(ArcStepper(stage));
    }
    return Stack(
      alignment: Alignment.center,
      children: stack,
    );
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
