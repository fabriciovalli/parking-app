import 'package:app4car/widgets/slider.dart';
import 'package:flutter/material.dart';

class ParkingCar extends StatelessWidget {
  final double top;
  final double left;
  final double width;

  ParkingCar({@required this.top, this.left = 100.0, this.width});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/forward.png',
            ),
            SizedBox(width: 10.0),
            Image.asset(
              'assets/car-orange.png',
              width: width,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
