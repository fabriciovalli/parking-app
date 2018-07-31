import 'package:app4car/widgets/slider.dart';
import 'package:flutter/material.dart';

class ParkingCar extends StatefulWidget {
  final double sliderPercent;
  final double goalPosition;

  ParkingCar(this.sliderPercent, [this.goalPosition = 0.0]);

  @override
  _ParkingCarState createState() => _ParkingCarState();
}

class _ParkingCarState extends State<ParkingCar> {
  final double paddingTop = 15.0;
  final double paddingBottom = 15.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final height = constraints.maxHeight;
              final sliderY = height * (1.0 - widget.sliderPercent);

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
            },
          ),
        ),
      ],
    );
  }
}
