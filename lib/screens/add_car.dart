import 'package:app4car/models/car_data.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/widgets/add_car_card.dart';
import 'package:flutter/material.dart';

class AddCarTab extends StatefulWidget {
  @override
  _AddCarTabState createState() => _AddCarTabState();
}

class _AddCarTabState extends State<AddCarTab> {
  static final CarData carData = new CarData(
      brand: 'Chevrolet',
      model: 'Onix',
      modelComplement: 'Advantage 1.4',
      year: 2017);

  List<CarAddItem> items = <CarAddItem>[
    new CarAddItem(
      car: carData,
      isExpanded: false,
      header: 'Schools',
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[]),
      ),
      icon: Icon(
        App4Car.app4carIcon,
        size: 30.0,
      ),
    ),
    new CarAddItem(
      car: carData,
      isExpanded: false,
      header: 'Schools',
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[]),
      ),
      icon: Icon(
        App4Car.app4carIcon,
        size: 30.0,
      ),
    ),
    new CarAddItem(
      car: carData,
      isExpanded: false,
      header: 'Schools',
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[]),
      ),
      icon: Icon(
        App4Car.app4carIcon,
        size: 30.0,
      ),
    ),
  ];

  Widget _buildSerchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        autocorrect: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Buscar Veículo',
          suffixIcon: new IconButton(
            onPressed: () {},
            icon: new Icon(
              Icons.search,
              color: Theme.of(context).buttonColor,
            ),
          ),
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
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: <Widget>[
          _buildSerchBar(context),
          _buildCarList(context),
        ],
      ),
    );
  }
}

class CarAddItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon icon;
  final CarData car;
  CarAddItem({this.car, this.isExpanded, this.header, this.body, this.icon});
}
