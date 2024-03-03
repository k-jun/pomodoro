import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/bloc/bloc.dart';
import 'package:alarm/alarm.dart';
import 'dart:math' as math;

class Ticker {
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}

final r = math.Random();

Future<void> set(dt) async {
  final as = AlarmSettings(
    id: r.nextInt(100),
    dateTime: dt.add(Duration(seconds: 1)),
    assetAudioPath: 'assets/x.mp3',
    vibrate: true,
    loopAudio: false,
    volume: 1.0,
    notificationTitle: 'This is the title',
    notificationBody: 'This is the body',
    enableNotificationOnKill: true,
  );
  await Alarm.set(alarmSettings: as);
}

Future<void> stop() async {
  await Alarm.stopAll();
}

class PomodoroBloc extends Bloc<Event, PomodoroState> {
  final Ticker _ticker;
  final int _pomodoro = 25 * 60;
  final int _breakShort = 5 * 60;
  final int _breakLong = 15 * 60;
  // final int _pomodoro = 10;
  // final int _breakShort = 6;
  // final int _breakLong = 8;
  final int _round = 4;

  StreamSubscription<int>? _tickerSubscription;

  PomodoroBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const PomodoroState.init()) {
    on<EventStart>(_onStarted);
    on<EventPause>(_onPaused);
    on<EventResume>(_onResumed);
    on<EventReset>(_onReset);
    on<EventTick>(_onTicked);
    on<EventFinish>(_onFinished);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(EventStart event, Emitter<PomodoroState> emit) async {
    if (state.sec == 0) {
      final int initialSec = _pomodoro;
      emit(PomodoroState(
        sec: initialSec,
        rnd: 0,
        set: initialSec,
        stat: Status.ready,
      ));
      add(EventStart());
      return;
    }

    await set(DateTime.now().add(Duration(seconds: state.sec)));

    emit(PomodoroState(
      sec: state.sec,
      rnd: state.rnd,
      set: state.sec,
      stat: Status.going,
      mode: state.mode,
    ));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: state.sec).listen((s) {
      add(EventTick(sec: s));
    });
  }

  Future<void> _onPaused(EventPause event, Emitter<PomodoroState> emit) async {
    _tickerSubscription?.pause();

    await stop();

    emit(PomodoroState(
      sec: state.sec,
      rnd: state.rnd,
      set: state.set,
      stat: Status.pause,
      mode: state.mode,
    ));
  }

  Future<void> _onResumed(
      EventResume resume, Emitter<PomodoroState> emit) async {
    _tickerSubscription?.resume();

    await set(DateTime.now().add(Duration(seconds: state.sec)));

    emit(PomodoroState(
      sec: state.sec,
      rnd: state.rnd,
      set: state.set,
      stat: Status.going,
      mode: state.mode,
    ));
  }

  Future<void> _onReset(EventReset event, Emitter<PomodoroState> emit) async {
    _tickerSubscription?.cancel();

    await stop();

    emit(const PomodoroState.init());
  }

  Future<void> _onTicked(EventTick event, Emitter<PomodoroState> emit) async {
    emit(PomodoroState(
      sec: event.sec,
      rnd: state.rnd,
      set: state.set,
      stat: Status.going,
      mode: state.mode,
    ));
    if (event.sec == 0) {
      await Future.delayed(const Duration(seconds: 1));
      add(EventFinish());
    }
  }

  void _onFinished(EventFinish event, Emitter<PomodoroState> emit) {
    if (state.rnd == _round && state.mode == Modes.last) {
      add(EventReset());
      return;
    }
    PomodoroState ns = PomodoroState(
      sec: _breakShort,
      rnd: state.rnd + 1,
      set: _breakShort,
      stat: Status.ready,
      mode: Modes.rest,
    );
    if (state.mode == Modes.rest) {
      ns = PomodoroState(
        sec: _pomodoro,
        rnd: state.rnd,
        set: _pomodoro,
        stat: Status.ready,
        mode: Modes.work,
      );
    }
    if (state.rnd == _round && state.mode == Modes.rest) {
      ns = PomodoroState(
        sec: _breakLong,
        rnd: state.rnd,
        set: _breakLong,
        stat: Status.ready,
        mode: Modes.last,
      );
    }
    emit(ns);
  }
}
