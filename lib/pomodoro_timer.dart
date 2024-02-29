import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';

class PomodoroTimer extends StatelessWidget {
  const PomodoroTimer({super.key});

  @override
  build(BuildContext context) {
    String format(num duration) {
      final String minutes = (duration ~/ 60).toString();
      final String seconds = (duration % 60).toString();
      if (minutes == "0") {
        return seconds;
      }
      return "$minutes:${seconds.padLeft(2, '0')}";
    }

    return BlocBuilder<PomodoroBloc, PomodoroState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomPaint(
              size: const Size(double.infinity, double.infinity),
              painter: CurvePainter(color: Colors.white, angle: 360),
              foregroundPainter: CurvePainter(
                color: Colors.red.shade700,
                angle: (1 - (state.sec / state.set)) * 360,
                pointer: true,
              ),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pomodoro #2 Complete",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      format(state.sec),
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          letterSpacing: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
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
      final pointerPaint = Paint()..color = color;
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
