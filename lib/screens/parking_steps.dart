import 'package:app4car/screens/parking/parking_car.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/widgets/arc_stepper.dart';
import 'package:app4car/widgets/bottom_appbar.dart';
import 'package:flutter/material.dart';

class ParkingSteps extends StatefulWidget {
  @override
  _ParkingStepsState createState() => new _ParkingStepsState();
}

class _ParkingStepsState extends State<ParkingSteps> {
  double slidePercent;

  @override
  void initState() {
    slidePercent = 0.35;
    super.initState();
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
        children: <Widget>[
          ParkingCar(slidePercent),
          ArcStepper(4),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            slidePercent += 0.03;
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
