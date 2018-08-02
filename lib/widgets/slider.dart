import 'package:app4car/colors.dart';
import 'package:flutter/material.dart';

class SideSlider extends StatefulWidget {
  final int markCount;
  final Color color;

  SideSlider({this.markCount, this.color});

  @override
  _SideSliderState createState() => _SideSliderState();
}

class _SideSliderState extends State<SideSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderMarks(
        markCount: widget.markCount,
        color: widget.color,
        paddingTop: 300.0,
        paddingBottom: 300.0);
  }
}

class SliderMarks extends StatelessWidget {
  final int markCount;
  final Color color;
  final double paddingTop;
  final double paddingBottom;
  final double position;
  final double goalMarkPosition;
  final double spotSize;
  final Color spotColor;

  SliderMarks(
      {this.markCount,
      this.color,
      this.paddingTop,
      this.paddingBottom,
      this.position = 0.0,
      this.goalMarkPosition,
      this.spotSize = 0.0,
      this.spotColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SliderMarksPainter(
        markCount: markCount,
        color: color,
        markThickness: 4.0,
        paddingTop: paddingTop,
        paddingBottom: paddingBottom,
        paddingLeft: 35.0,
        position: position,
        goalMarkPosition: goalMarkPosition,
        spotSize: spotSize,
        spotColor: spotColor,
      ),
    );
  }
}

class SliderMarksPainter extends CustomPainter {
  final double markWidth = 35.0;

  final int markCount;
  final Color color;
  final double markThickness;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final Paint markPaint;
  final double position;
  final double goalMarkPosition;
  final double spotSize;
  final Color spotColor;

  SliderMarksPainter(
      {this.markCount,
      this.color,
      this.markThickness,
      this.paddingTop,
      this.paddingBottom,
      this.paddingLeft,
      this.position,
      this.goalMarkPosition,
      this.spotSize,
      this.spotColor})
      : markPaint = new Paint()
          ..color = color
          ..strokeWidth = markThickness
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.square;

  @override
  void paint(Canvas canvas, Size size) {
    final paintHeight = size.height - paddingTop - paddingBottom;
    final gap = paintHeight / (markCount - 1);

    // if (goalMarkPosition != null) {
    //   markPaint.color = spotColor;
    //   canvas.drawLine(
    //       Offset(0.0 + paddingLeft - markWidth * 0.5, goalMarkPosition),
    //       Offset(0.0 + paddingLeft + markWidth, goalMarkPosition),
    //       markPaint);
    // }

    for (int i = 0; i < markCount; i++) {
      final markY = i * gap + paddingTop;
      double startingMarkX = 0.0 + paddingLeft;

      if (goalMarkPosition != null &&
          markY <= (goalMarkPosition + spotSize / 2) &&
          markY >= (goalMarkPosition - spotSize / 2)) {
        markPaint.color = spotColor;
      } else {
        markPaint.color = color;
      }
      if (goalMarkPosition != null &&
          markY < goalMarkPosition &&
          (markY + gap) > goalMarkPosition) {
        startingMarkX = 0.0 + paddingLeft - markWidth * 0.5;
      }
      canvas.drawLine(Offset(startingMarkX, markY),
          Offset(0.0 + paddingLeft + markWidth, markY), markPaint);
    }

    Paint positionPaint = new Paint()
      ..color = kApp4CarOrange.withOpacity(0.9)
      ..strokeWidth = 13.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (position != 0.0) {
      if (goalMarkPosition != null &&
          position < goalMarkPosition &&
          (position + gap) > goalMarkPosition) {
        positionPaint.color = kApp4CarGreen;
      } else {
        positionPaint.color = kApp4CarOrange;
      }

      canvas.drawLine(Offset(0.0 + paddingLeft - markWidth * 0.2, position),
          Offset(0.0 + paddingLeft + markWidth, position), positionPaint);
      canvas.drawCircle(Offset(0.0 + paddingLeft - markWidth * 0.5, position),
          6.0, positionPaint);

      if (position < goalMarkPosition) {
        // desenhar seta pra cima dentro do circulo do marcador
      } else {
        // desenhar seta pra baixo dentro do circulo do marcador
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
