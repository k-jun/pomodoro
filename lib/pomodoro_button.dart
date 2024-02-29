import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';

class PomodoroButton extends StatelessWidget {
  PomodoroButton({super.key});

  @override
  Widget build(BuildContext context) {
    final pb = BlocProvider.of<PomodoroBloc>(context);

    return BlocBuilder<PomodoroBloc, PomodoroState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.topCenter,
          child: 
          IconButton(
            icon: const Icon(
              Icons.play_circle_outline,
              // Icons.pause_circle_outline,
              color: Colors.white,
              size: 90,
            ),
            onPressed: () {
              pb.add(const EventStart(duration: 180));
            },
          ),
        );
      },
    );
  }
}
