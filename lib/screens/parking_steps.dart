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
  double sliderPercent;
  int stage;

  @override
  void initState() {
    sliderPercent = 0.35;
    stage = 1;
    super.initState();
  }

  List<Widget> _buildContent() {
    List<Widget> items = <Widget>[
      _buildStack(),
    ];
    if (sliderPercent > 0.5) {
      items.add(ArcStepper(stage));
    }
    return items;
  }

  Widget _buildStack() {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
      child: LayoutBuilder(
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, BoxConstraints constraints) {
    final height = constraints.maxHeight;
    final sliderY = height * (1.0 - sliderPercent);

    return Stack(
      children: <Widget>[
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
                spotSize: height / 6,
              ),
            )
          ],
        ),
        Positioned(
          top: sliderY,
          left: 150.0,
          child: Center(
            child: Image.asset(
              'assets/car-orange.png',
              height: height / 3,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
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
      body: Stack(
        children: _buildContent(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            sliderPercent += 0.03;
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
