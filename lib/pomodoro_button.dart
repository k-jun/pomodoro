import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class PomodoroButton extends StatefulWidget {
  PomodoroButton({super.key});

  @override
  State<PomodoroButton> createState() => _PomodoroButton();
}

class _PomodoroButton extends State<PomodoroButton>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final pb = BlocProvider.of<PomodoroBloc>(context);
      pb.add(EventScreenResume());
    }
  }

  @override
  Widget build(BuildContext context) {
    final pb = BlocProvider.of<PomodoroBloc>(context);

    return BlocBuilder<PomodoroBloc, PomodoroState>(
      builder: (context, state) {
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

        return Container(
            alignment: Alignment.topCenter,
            child: state.stat == Status.going
                ? pause()
                : (state.stat == Status.pause ? resume() : start()));
      },
    );
  }
}
