import 'package:app4car/utils/app4car.dart';
import 'package:flutter/material.dart';

class CarRadioButtonRow extends StatefulWidget {
  @override
  _CarRadioButtonRowState createState() => new _CarRadioButtonRowState();
}

class _CarRadioButtonRowState extends State<CarRadioButtonRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50.0,
      decoration: BoxDecoration(
        color: Colors.blue[900],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          OutlineButton.icon(
            icon: Icon(
              Icons.list,
              color: Colors.blue[700],
            ),
            label: Text(
              App4Car.myCars,
              style: TextStyle(color: Colors.blue[700]),
            ),
            onPressed: () {},
            borderSide: BorderSide(
              color: Colors.blue[700],
            ),
          ),
          OutlineButton.icon(
            icon: Icon(
              Icons.add,
              color: Colors.blue[700],
            ),
            label: Text(
              App4Car.addCar,
              style: TextStyle(color: Colors.blue[700]),
            ),
            onPressed: () {},
            borderSide: BorderSide(
              color: Colors.blue[700],
            ),
          )
        ],
      ),
    );
  }
}
