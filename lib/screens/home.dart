import 'package:app4car/utils/app4car_navigator.dart';
import 'package:flutter/material.dart';
import 'package:app4car/screens/add_car.dart';
import 'package:app4car/screens/car_list.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/widgets/bottom_appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(App4Car.appName),
          centerTitle: true,
          elevation: 0.0,
          leading: Icon(Icons.arrow_back),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.menu),
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.list),
                text: App4Car.myCars,
              ),
              Tab(
                icon: Icon(Icons.add),
                text: App4Car.addCar,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            new CarListTab(),
            new AddCarTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            App4CarNavigator.goToParking(context);
          },
          child: Icon(
            Icons.play_arrow,
          ),
          backgroundColor: Theme.of(context).buttonColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: new CustomBottomAppBar(),
      ),
    );
  }
}
