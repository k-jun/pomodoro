import 'package:equatable/equatable.dart';

/// Events - input to a Bloc. Base on user interactions
abstract class Event extends Equatable {
  const Event();

  @override
  List<Object> get props => [];
}

class EventStart extends Event {}

class EventPause extends Event {}

class EventResume extends Event {}

class EventReset extends Event {}

class EventFinish extends Event {}

class EventTick extends Event {
  final int sec;

  const EventTick({required this.sec});

  @override
  List<Object> get props => [sec];
}
