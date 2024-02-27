import 'package:flutter/material.dart';

class PomodoroButton extends StatelessWidget {
  PomodoroButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: const Icon(
        // Icons.play_circle_outline,
        Icons.pause_circle_outline,
        color: Colors.white,
        size: 90,
      ),
    );
  }
}