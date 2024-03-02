import 'package:equatable/equatable.dart';

/// States - output of a Bloc. Represents a part of application/page state
enum Status {
  ready,
  going,
  pause,
}

enum Modes {
  work,
  rest,
  last,
}

class PomodoroState extends Equatable {
  final int sec;
  final int rnd;
  final int set;
  final Status stat;
  final Modes mode;

  const PomodoroState({
    required this.sec,
    required this.rnd,
    required this.set,
    this.stat = Status.ready,
    this.mode = Modes.work,
  });
  const PomodoroState.init() : this(sec: 0, rnd: 0, set: 0);

  @override
  List<Object> get props => [sec, rnd, set, stat, mode];
}
