import 'package:flutter/material.dart';
import 'bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PomodoroStatus extends StatelessWidget {
  const PomodoroStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final pb = BlocProvider.of<PomodoroBloc>(context);
    return Container(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: const Icon(
          Icons.refresh,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {
          pb.add(EventReset());
        },
      ),
    );
  }
}
