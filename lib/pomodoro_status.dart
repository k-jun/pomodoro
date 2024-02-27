import 'package:flutter/material.dart';

class PomodoroStatus extends StatelessWidget {
  const PomodoroStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: const Icon(
        Icons.settings,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}
