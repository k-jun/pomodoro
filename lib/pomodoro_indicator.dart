import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class PomodoroIndicator extends StatelessWidget {
  PomodoroIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red.shade700,
      ),
      height: 30,
      width: 30,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              circle,
              circle,
              circle,
              circle,
            ],
          ),
        ),
        Text(
          "Take a short break",
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
