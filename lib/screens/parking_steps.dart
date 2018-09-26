import 'package:app4car/colors.dart';
import 'package:app4car/models/car_data.dart';
import 'package:app4car/models/controller_data.dart';
import 'package:app4car/screens/parking/step_four.dart';
import 'package:app4car/screens/parking/step_one.dart';
import 'package:app4car/screens/parking/step_three.dart';
import 'package:app4car/screens/parking/step_two.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/widgets/bottom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:app4car/utils/car_communication.dart';
import 'package:flutter/services.dart';

class ParkingSteps extends StatefulWidget {
  final CarData carData;

  const ParkingSteps({Key key, this.carData}) : super(key: key);

  @override
  _ParkingStepsState createState() => new _ParkingStepsState();
}

class _ParkingStepsState extends State<ParkingSteps> {
  int stage;
  ControllerData _data;
  CarCommunication controller = CarCommunication();
  @override
  void initState() {
    super.initState();
    controller.addListener(_onMessageReceived);
    controller.send(widget.carData);
    stage = 1;
  }

  @override
  void dispose() {
    controller.removeListener(_onMessageReceived);
    super.dispose();
  }

  _onMessageReceived(message) {
    ControllerData data = controllerDataFromJson(message);
    setState(() {
      _data = data;
      stage = int.parse(_data.passo);
    });
  }

  @override
  Widget build(BuildContext context) {
    _data = new ControllerData();
    stage = 4;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Widget stepToRender;
    switch (stage) {
      case 1:
        stepToRender = ParkingStepOne(
          communicationController: controller,
        );
        break;
      case 2:
        stepToRender = ParkingStepTwo(
          communicationController: controller,
        );
        break;
      case 3:
        stepToRender = ParkingStepThree(
          communicationController: controller,
        );
        break;
      case 4:
        stepToRender = ParkingStepFour(
          communicationController: controller,
        );
        break;
      default:
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(App4Car.appName),
        centerTitle: true,
        elevation: 5.0,
        automaticallyImplyLeading: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.menu),
          ),
        ],
      ),
      body: _data == null ? Center(child: CircularProgressIndicator()) : stepToRender,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (stage < 4) {
              stage++;
            } else {
              stage = 1;
            }
          });
          // _controller.repeat();
        },
        child: Icon(
          App4Car.driveIcon,
          color: Colors.white,
          size: 35.0,
        ),
        backgroundColor: Theme.of(context).buttonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}

class ResultadoVaga extends StatelessWidget {
  final bool fit;

  ResultadoVaga(this.fit);

  @override
  Widget build(BuildContext context) {
    return new RichText(
      textAlign: TextAlign.center,
      text: new TextSpan(
        text: 'Seu carro ',
        style: TextStyle(
          color: fit ? kApp4CarGreen : Colors.red,
          fontSize: 20.0,
        ),
        children: <TextSpan>[
          new TextSpan(text: fit ? 'cabe' : 'não cabe', style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(text: ' na vaga!'),
        ],
      ),
    );
  }
}
