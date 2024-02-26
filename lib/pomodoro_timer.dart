import 'package:flutter/material.dart';
import 'dart:math' as math;

class PomodoroTimer extends StatelessWidget {
  const PomodoroTimer({super.key});

  @override
  build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: CurvePainter(color: Colors.white, angle: 360),
        foregroundPainter: CurvePainter(
          color: Colors.red.shade700,
          angle: 128,
          pointer: true,
        ),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pomodoro #2 Complete",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              Text(
                "3:40",
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double angle;
  final Color color;
  final double width = 7;
  final bool pointer;
  final double pointerRaidus = 12;

  CurvePainter({
    required this.color,
    required this.angle,
    this.pointer = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.min(size.width / 2, size.height / 2) - width / 2;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      degreeToRadians(-90),
      degreeToRadians(angle),
      false,
      paint,
    );

    if (pointer) {
      final pointerPaint = Paint()
        ..color = color
        ..strokeWidth = width;
      final pointerOffset =
          center + Offset.fromDirection(degreeToRadians(angle - 90), radius);
      canvas.drawCircle(
        pointerOffset,
        pointerRaidus,
        pointerPaint,
      );
    }
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
