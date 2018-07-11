import 'dart:async';

import 'package:app4car/models/car_data.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/utils/widget_utils.dart';
import 'package:app4car/widgets/buttons.dart';
import 'package:app4car/widgets/input_dropdown.dart';
import 'package:flutter/material.dart';

class AddCarCard extends StatefulWidget {
  const AddCarCard({Key key, this.carData}) : super(key: key);
  final CarData carData;

  @override
  _AddCarCardState createState() => new _AddCarCardState();
}

class _AddCarCardState extends State<AddCarCard> {
  final List<String> _allModels = <String>[
    App4Car.carModel,
    'Advantage 1.4',
    'CLI 2.0 16v',
    'Comfort Plus 1.0',
  ];
  String _selectedModel = App4Car.carModel;
  bool isExpanded = false;
  CarData _selectedCar = new CarData();
  DateTime selectedDate = DateTime.now();

  Widget _buildHeader(BuildContext context) {
    return ListTile(
      leading: IconButton(
        padding: EdgeInsets.all(1.0),
        iconSize: 40.0,
        icon: Icon(
          Icons.drive_eta,
        ),
        onPressed: null,
      ),
      title: Text(
        widget.carData.model,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
      ),
      subtitle: Text(
        widget.carData.brand,
        style: TextStyle(fontSize: 13.0),
      ),
      trailing: IconButton(
        padding: EdgeInsets.all(1.0),
        iconSize: 35.0,
        icon: Icon(
          Icons.add,
          color: Theme.of(context).buttonColor,
        ),
        onPressed: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
      ),
    );
  }

  Future<Null> _selectYear(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: selectedDate,
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _selectedCar.year = picked.year;
      });
    }
  }

  Widget _buildExpandedBody() {
    return isExpanded
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            margin: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Divider(
                  height: 5.0,
                ),
                new DropdownButtonHideUnderline(
                  child: Column(
                    children: <Widget>[
                      new InputDecorator(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.branding_watermark,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        isEmpty: false,
                        child: new DropdownButton<String>(
                          value: _selectedModel,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _selectedModel = newValue;
                            });
                          },
                          items: _allModels.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Expanded(
                            flex: 4,
                            child: new InputDropdown(
                              labelText: 'Ano',
                              valueText: selectedDate.year.toString(),
                              onPressed: () {
                                _selectYear(context);
                              },
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            flex: 3,
                            child: RoundButton(
                              borderRadius: 5.0,
                              onPressed: () {},
                              color: Colors.deepOrangeAccent,
                              text: 'Adicionar',
                              height: 50.0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      _buildHeader(context),
    ];
    addIfNonNull(_buildExpandedBody(), children);
    return new Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        color: Theme.of(context).primaryColor,
        child: new Column(
          children: children,
        ));
  }
}
