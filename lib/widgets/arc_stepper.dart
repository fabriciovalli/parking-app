import 'package:app4car/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class ArcStepper extends StatelessWidget {
  final int step;

  ArcStepper(this.step);

  @override
  Widget build(BuildContext context) {
    Widget stepImage;

    switch (step) {
      case 1:
        stepImage = Image.asset('assets/step-one.png');
        break;
      case 2:
        stepImage = Image.asset('assets/step-two.png');
        break;
      case 3:
        stepImage = Image.asset('assets/step-three.png');
        break;
      case 4:
        stepImage = Image.asset('assets/step-four.png');
        break;
      case 5:
        stepImage = Image.asset('assets/step-completed.png');
        break;
      default:
        stepImage = Image.asset('assets/step-completed.png');
    }
    List<Widget> items = <Widget>[];
    addIfNonNull(stepImage, items);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: items,
      ),
    );
  }
}
