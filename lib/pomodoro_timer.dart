import 'package:flutter/material.dart';
import 'dart:math' as math;

class PomodoroTimer extends StatelessWidget {
  const PomodoroTimer({super.key});

  @override
  build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: CurvePainter(colors: [Colors.black]),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue)
          ),
          child: Text("CHILD"),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = Paint()
      ..color = Colors.black.withOpacity(1.0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(Rect.fromCircle(center: shdowPaintCenter, radius: 100),
        degreeToRadians(90), degreeToRadians(120), false, shdowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
