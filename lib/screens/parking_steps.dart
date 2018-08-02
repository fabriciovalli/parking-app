import 'package:app4car/colors.dart';
import 'package:app4car/screens/parking/parking_car.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/widgets/arc_stepper.dart';
import 'package:app4car/widgets/bottom_appbar.dart';
import 'package:app4car/widgets/slider.dart';
import 'package:flutter/material.dart';

class ParkingSteps extends StatefulWidget {
  @override
  _ParkingStepsState createState() => new _ParkingStepsState();
}

class _ParkingStepsState extends State<ParkingSteps> {
  final flexTopCar = 1;
  final flexSpot = 3;
  final flexBottomCar = 2;

  final double paddingTop = 15.0;
  final double paddingBottom = 15.0;

  double carSpeed = 0.015;
  double sliderPercent;
  int stage;
  bool isMovingForward;

  @override
  void initState() {
    sliderPercent = 0.35;
    stage = 1;
    isMovingForward = true;
    super.initState();
  }

  Widget _builder(BuildContext context, BoxConstraints constraints) {
    final height = constraints.maxHeight;
    final width = constraints.maxWidth;
    final sliderY = height * (1.0 - sliderPercent);

    final Size parkingCarSize = Size(width / 3.2, height * 0.4);
    final Size parkingSpotSize = Size(width / 3.2, height * 0.4);

    double goalPosition = height *
        (flexTopCar + flexSpot / 2) *
        (1 / (flexTopCar + flexSpot + flexBottomCar));

    double spotSize =
        height * (flexSpot / (flexTopCar + flexSpot + flexBottomCar));

    double sliderPosition = sliderY + parkingCarSize.height * 0.45;

    isMovingForward = (sliderPosition + carSpeed >= goalPosition);

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
      ParkingCar(
        top: sliderY,
        left: width / 4.2,
        width: parkingCarSize.width,
        isForward: isMovingForward,
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
                decoration: BoxDecoration(
                    border: Border.all(color: kApp4CarGreen, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0)),
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
    ];

    if (sliderPosition < goalPosition &&
        sliderPosition + height * (1.0 - carSpeed) > goalPosition) {
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
          setState(() {
            isMovingForward
                ? carSpeed = carSpeed.abs()
                : carSpeed = -carSpeed.abs();
            sliderPercent += carSpeed;
          });
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
          new TextSpan(
              text: fit ? 'cabe' : 'não cabe',
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(text: ' na vaga!'),
        ],
      ),
    );
  }
}
