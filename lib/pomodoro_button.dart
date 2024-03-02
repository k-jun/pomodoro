import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/bloc/pomodoro_event.dart';
import 'bloc/bloc.dart';

class PomodoroButton extends StatelessWidget {
  PomodoroButton({super.key});

  @override
  Widget build(BuildContext context) {
    final pb = BlocProvider.of<PomodoroBloc>(context);

    Widget start() {
      return IconButton(
        icon: const Icon(
          Icons.play_circle_outline,
          color: Colors.white,
          size: 90,
        ),
        onPressed: () {
          pb.add(EventStart());
        },
      );
    }

    Widget pause() {
      return IconButton(
        icon: const Icon(
          Icons.pause_circle_outline,
          color: Colors.white,
          size: 90,
        ),
        onPressed: () {
          pb.add(EventPause());
        },
      );
    }

    Widget resume() {
      return IconButton(
        icon: const Icon(
          Icons.play_circle_outline,
          color: Colors.white,
          size: 90,
        ),
        onPressed: () {
          pb.add(EventResume());
        },
      );
    }

    return BlocBuilder<PomodoroBloc, PomodoroState>(
      builder: (context, state) {
        return Container(
            alignment: Alignment.topCenter,
            child: state.stat == Status.going ? pause() : (state.stat == Status.pause ? resume() : start()));
      },
    );
  }
}
