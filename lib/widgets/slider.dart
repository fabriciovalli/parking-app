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

  SliderMarks(
      {this.markCount,
      this.color,
      this.paddingTop,
      this.paddingBottom,
      this.position = 0.0});

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

  SliderMarksPainter(
      {this.markCount,
      this.color,
      this.markThickness,
      this.paddingTop,
      this.paddingBottom,
      this.paddingLeft,
      this.position,
      this.goalMarkPosition})
      : markPaint = new Paint()
          ..color = color
          ..strokeWidth = markThickness
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.square;

  @override
  void paint(Canvas canvas, Size size) {
    final paintHeight = size.height - paddingTop - paddingBottom;
    final gap = paintHeight / (markCount - 1);

    for (int i = 0; i < markCount; i++) {
      final markY = i * gap + paddingTop;

      canvas.drawLine(Offset(0.0 + paddingLeft, markY),
          Offset(0.0 + paddingLeft + markWidth, markY), markPaint);
    }

    Paint positionPaint = new Paint()
      ..color = Colors.deepOrangeAccent.withOpacity(0.9)
      ..strokeWidth = 13.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (position != 0.0) {
      canvas.drawLine(Offset(0.0 + paddingLeft - markWidth * 0.2, position),
          Offset(0.0 + paddingLeft + markWidth, position), positionPaint);
      positionPaint.color = Colors.deepOrangeAccent.withOpacity(1.0);
      canvas.drawCircle(Offset(0.0 + paddingLeft - markWidth * 0.5, position),
          6.0, positionPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
