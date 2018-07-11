import 'package:app4car/widgets/car_item.dart';
import 'package:flutter/material.dart';

class CarListTab extends StatelessWidget {

    Widget _buildCarList() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          CarItem(),
          CarItem(),
          CarItem(),
          CarItem(),
          CarItem(),
          CarItem(),
          CarItem(),
          CarItem(),
          CarItem(),
          CarItem(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      decoration: BoxDecoration(color: Colors.blue[900]),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // CarRadioButtonRow(),
          _buildCarList(),
        ],
      ),
    );
  }
}
