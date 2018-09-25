import 'package:flutter/material.dart';

class ParkingCar extends StatelessWidget {
  final double top;
  final double left;
  final double width;
  final bool isForward;

  ParkingCar({@required this.top, this.left = 100.0, this.width, this.isForward});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = <Widget>[];
    if (isForward != null) {
      items.addAll(
        [
          Image.asset(
            isForward ? 'assets/forward.png' : 'assets/reverse.png',
          ),
          SizedBox(width: 10.0),
        ],
      );
    }
    items.add(
      Image.asset(
        'assets/car-orange.png',
        width: width,
        fit: BoxFit.contain,
      ),
    );
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }
}
