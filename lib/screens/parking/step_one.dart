import 'package:app4car/colors.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/widgets/bottom_appbar.dart';
import 'package:app4car/widgets/slider.dart';
import 'package:flutter/material.dart';

class ParkingStepOneScreen extends StatefulWidget {
  @override
  _ParkingStepOneScreenState createState() => new _ParkingStepOneScreenState();
}

class _ParkingStepOneScreenState extends State<ParkingStepOneScreen>
    with SingleTickerProviderStateMixin {
  double percentage = 0.0;
  int stage = 1;
  double finishXPosition;
  double finishYPosition;
  final double width = 100.0;
  double topCarHeight = 0.0;

  @override
  void initState() {
    super.initState();
    percentage = 0.0;
    stage = 1;
  }

  Widget _buildParkedCars() {
    final Size screenSize = MediaQuery.of(context).size;
    final double appBarSize = 180.0;
    final double paddingTop = 16.0;

    final Size topCarSize = Size(screenSize.width / 3,
        (screenSize.height - appBarSize - paddingTop) * 0.4);
    topCarHeight = topCarSize.height;
    final Size parkingSpotSize = Size(screenSize.width / 3,
        (screenSize.height - appBarSize - paddingTop) * 0.45);
    final Size bottomCarSize = Size(screenSize.width / 3,
        (screenSize.height - appBarSize - paddingTop) * 0.15);

    return Container(
      width: topCarSize.width,
      padding: EdgeInsets.only(right: 8.0, top: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset("assets/car-white.png", height: topCarSize.height, fit: BoxFit.contain,),
          new SizedBox(
            height: 8.0,
          ),
          new Container(
            height: parkingSpotSize.height,
            decoration: BoxDecoration(
                border: Border.all(color: kApp4CarGreen, width: 2.0),
                borderRadius: BorderRadius.circular(8.0)),
          ),
          new SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: Image.asset(
                "assets/car-white.png",
                width: parkingSpotSize.width,
                fit: BoxFit.fitWidth,
                alignment: Alignment(0.0, -1.0),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildParkingCar() {
    final Size screenSize = MediaQuery.of(context).size;
    final double appBarSize = 180.0;
    final double paddingTop = 16.0;
    final Size parkingCar = Size(screenSize.width / 3,
        (screenSize.height - appBarSize - paddingTop) * 0.4);

    return Container(
      width: parkingCar.width,
      padding: EdgeInsets.only(left: 10.0, top: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: parkingCar.height,
            child: Stack(children: <Widget>[
              Image.asset(
                'assets/car-orange.png',
              ),
              Positioned(
                left: 0.0,
                top: 0.0,
                child: FractionalTranslation(
                    translation: const Offset(0.13, 0.7),
                    child: Image.asset(
                      'assets/wheel-right.png',
                    )),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CustomBottomAppBar bottomAppBar = new CustomBottomAppBar();
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
      body: Row(
//        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SliderMarks(
                    markCount: 60,
                    color: Color(0x55FFFFFF),
                    paddingTop: 15.0,
                    paddingBottom: 15.0),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: _buildParkingCar(),
          ),
          _buildParkedCars(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (percentage >= 1.15) {
              percentage = 0.0;
            } else {
              percentage += 0.03;
              print(percentage);
            }
          });
        },
        child: Icon(
          Icons.play_arrow,
        ),
        backgroundColor: Theme.of(context).buttonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomAppBar,
    );
  }
}
