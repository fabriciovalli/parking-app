import 'dart:async';

import 'package:app4car/colors.dart';
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
  final List<String> _allYears = <String>[
    App4Car.carYear,
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
  ];
  String _selectedModel = App4Car.carModel;
  String _selectedYear = App4Car.carYear;
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
        icon: isExpanded
            ? Icon(
                Icons.close,
                color: Theme.of(context).buttonColor,
              )
            : Icon(
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
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
      height: !isExpanded ? 0.0 : 160.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      margin: !isExpanded
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Divider(
            height: 5.0,
            color: Colors.white,
          ),
          SizedBox(
            height: 10.0,
          ),
          DropdownButtonHideUnderline(
            child: new InputDecorator(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.branding_watermark,
                    color: Colors.black,
                  ),
                ),
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
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
          ),
          SizedBox(
            height: 10.0,
          ),
          DropdownButtonHideUnderline(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: new InputDecorator(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    isEmpty: false,
                    child: new DropdownButton<String>(
                      value: _selectedYear,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _selectedYear = newValue;
                        });
                      },
                      items: _allYears.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 1,
                  child: RoundButton(
                    borderRadius: 5.0,
                    onPressed: () {
                      setState(() {
                        isExpanded = false;
                      });
                    },
                    color: Colors.deepOrangeAccent,
                    text: 'Adicionar',
                    height: 65.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      _buildHeader(context),
    ];
    addIfNonNull(_buildExpandedBody(), children);
    return new Card(
        color: Theme.of(context).primaryColor,
        child: new Column(
          children: children,
        ));
  }
}
