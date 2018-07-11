import 'package:app4car/models/car_data.dart';
import 'package:app4car/widgets/add_car_card.dart';
import 'package:flutter/material.dart';

class AddCarTab extends StatelessWidget {
  final CarData carData = new CarData(
      brand: 'Chevrolet',
      model: 'Onix',
      modelComplement: 'Advantage 1.4',
      year: 2017);

  Widget _buildSerchBar(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Buscar Veículo',
        suffixIcon: new IconButton(
          onPressed: () {},
          icon: new Icon(Icons.search, color: Theme.of(context).buttonColor,),
        ),
      ),
    );
  }

  Widget _buildCarList(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
         AddCarCard(
            carData: carData,
          ),
          AddCarCard(
            carData: carData,
          ),
          AddCarCard(
            carData: carData,
          ),
          AddCarCard(
            carData: carData,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue[900]),
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      child: Column(
        children: <Widget>[
          _buildSerchBar(context),
          _buildCarList(context),
        ],
      ),
    );
  }
}
