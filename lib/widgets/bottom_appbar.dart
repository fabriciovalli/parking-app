import 'package:app4car/utils/app4car.dart';
import 'package:app4car/utils/app4car_navigator.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final double iconSize = 35.0;

  Widget _buildMenuContents(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
      child: Row(
        children: <Widget>[
          new IconButton(
            icon: Icon(
              App4Car.notificationsIcon,
              size: this.iconSize,
            ),
            onPressed: () {},
          ),
          new SizedBox(
            width: 20.0,
          ),
          new IconButton(
            icon: Icon(
              Icons.location_on,
              size: this.iconSize,
            ),
            onPressed: () {
              App4CarNavigator.goToParkingSlider(context);
            },
          ),
          Expanded(child: const SizedBox()),
          new IconButton(
            icon: Icon(
              App4Car.diagnosticIcon,
              size: this.iconSize,
            ),
            onPressed: () {},
          ),
          new SizedBox(
            width: 20.0,
          ),
          new IconButton(
            icon: Icon(
              App4Car.thiefIcon,
              size: this.iconSize,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new BottomAppBar(
      hasNotch: false,
      color: Colors.white,
      child: Container(
        height: 70.0,
        child: _buildMenuContents(context),
      ),
    );
  }
}
