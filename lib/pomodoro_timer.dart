import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimer();
}

class _PomodoroTimer extends State<PomodoroTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(_controller);
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(PomodoroState s) {
    if (s.sec == 0 || s.stat == Status.ready || s.stat == Status.pause) {
      return;
    }
    _controller.reset();
    _animation = Tween(begin: 1.0 - (s.sec / s.set), end: 1.0 - ((s.sec - 1) / s.set))
        .animate(_controller);
    _controller.forward();
  }

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
      String message(PomodoroState s) {
        String mess = "Pomodoro #${s.rnd + 1} Progress";
        if (s.mode == Modes.rest || s.mode == Modes.last) {
          mess = "Pomodoro #${s.rnd} Complete";
        }
        return mess;
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: BlocListener<PomodoroBloc, PomodoroState>(
              listener: (context, state) => _animateTo(state),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => CustomPaint(
                  size: const Size(double.infinity, double.infinity),
                  painter: CurvePainter(color: Colors.red.shade700, angle: 360),
                  foregroundPainter: CurvePainter(
                    color: Colors.white,
                    angle: state.set == 0 ? 0 : _animation.value * 360,
                    pointer: true,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          message(state),
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
            ),
          )
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
