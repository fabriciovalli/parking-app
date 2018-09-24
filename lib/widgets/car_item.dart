import 'package:app4car/colors.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/utils/app4car_navigator.dart';
import 'package:flutter/material.dart';

class CarItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      color: Theme.of(context).primaryColor,
      child: ListTile(
        leading: Icon(
          App4Car.app4carIcon,
          size: 30.0,
        ),
        title: const Text(
          'Onix Advantage 1.4',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
        ),
        subtitle: const Text(
          'Chevrolet (2017)',
          style: TextStyle(fontSize: 13.0),
        ),
        trailing: IconButton(
          padding: EdgeInsets.all(1.0),
          iconSize: 35.0,
          icon: Icon(
            App4Car.driveIcon,
            color: kApp4CarOrange,
          ),
          onPressed: () {
            App4CarNavigator.goToParking(context);
          },
        ),
      ),
    );
  }
}
