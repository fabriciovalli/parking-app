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

  SliderMarks(
      {this.markCount, this.color, this.paddingTop, this.paddingBottom});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SliderMarksPainter(
          markCount: markCount,
          color: color,
          markThickness: 4.0,
          paddingTop: paddingTop,
          paddingBottom: paddingBottom,
          paddingLeft: 20.0),
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

  SliderMarksPainter(
      {this.markCount,
      this.color,
      this.markThickness,
      this.paddingTop,
      this.paddingBottom,
      this.paddingLeft})
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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
