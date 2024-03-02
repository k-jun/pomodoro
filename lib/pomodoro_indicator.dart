import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';

class PomodoroIndicator extends StatelessWidget {
  PomodoroIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    Widget circle(bool b) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: b ? Colors.white : Colors.red.shade700,
        ),
        height: 30,
        width: 30,
      );
    }

    String message(PomodoroState s) {
      String mess = "Focus on a task";
      if (s.mode == Modes.rest) {
        mess = "Take a short break";
      }
      if (s.mode == Modes.last) {
        mess = "Take a long break";
      }
      return mess;
    }

    return BlocBuilder<PomodoroBloc, PomodoroState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  circle(state.rnd >= 1),
                  circle(state.rnd >= 2),
                  circle(state.rnd >= 3),
                  circle(state.rnd >= 4),
                ],
              ),
            ),
            Text(
              message(state),
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
