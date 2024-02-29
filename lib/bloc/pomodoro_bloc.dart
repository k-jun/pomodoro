import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pomodoro_event.dart';
import 'pomodoro_state.dart';

class Ticker {
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}

class PomodoroBloc extends Bloc<Event, PomodoroState> {
  final Ticker _ticker;
  final int _pomodoro = 25 * 60;
  final int _breakShort = 5 * 60;
  final int _breakLong = 15 * 60;
  final int _roun = 4;

  StreamSubscription<int>? _tickerSubscription;

  PomodoroBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const PomodoroState.init()) {
    on<EventStart>(_onStarted);
    on<EventPause>(_onPaused);
    on<EventResume>(_onResumed);
    on<EventReset>(_onReset);
    on<EventTick>(_onTicked);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(EventStart event, Emitter<PomodoroState> emit) {
    emit(PomodoroState(
      sec: event.duration,
      rnd: 0,
      set: event.duration,
      stat: Status.work,
    ));
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(ticks: event.duration).listen((duration) {
      add(EventTick(duration: duration));
    });
  }

  void _onPaused(EventPause event, Emitter<PomodoroState> emit) {
    _tickerSubscription?.pause();
  }

  void _onResumed(EventResume resume, Emitter<PomodoroState> emit) {
    _tickerSubscription?.resume();
  }

  void _onReset(EventReset event, Emitter<PomodoroState> emit) {
    _tickerSubscription?.cancel();
    // emit(const StateReady(duration: 0, round: 0, status: Status.pomodoro));
  }

  void _onTicked(EventTick event, Emitter<PomodoroState> emit) {
    emit(PomodoroState(
      sec: event.duration,
      rnd: state.rnd,
      set: state.set,
      stat: Status.work,
    ));
  }
}
