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
  final double paddingTop = 15.0;
  final double paddingBottom = 15.0;
  final double carSpeed = 0.015;
  double sliderPercent;
  int stage;

  @override
  void initState() {
    sliderPercent = 0.35;
    stage = 1;
    super.initState();
  }

  Widget _builder(BuildContext context, BoxConstraints constraints) {
    final height = constraints.maxHeight;
    final width = constraints.maxWidth;
    final sliderY = height * (1.0 - sliderPercent);
    final Size parkingCarSize = Size(width / 3.2, height * 0.4);

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
              position: sliderY + height / 6,
              goalMarkPosition: height / 2.5,
              spotSize: height * 0.2,
            ),
          )
        ],
      ),
      ParkingCar(
        top: sliderY,
        left: width / 4.2,
        width: parkingCarSize.width,
      ),
    ];

    if ((sliderY + height / 6) < height / 2.5 &&
        (sliderY + height / 6) + height * (1.0 - carSpeed) > height / 2.5) {
      stage = 2;
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
