
import 'package:equatable/equatable.dart';

/// Events - input to a Bloc. Base on user interactions
abstract class Event extends Equatable {
  const Event();

  @override
  List<Object> get props => [];
}

class EventStart extends Event {
  final int duration;

  const EventStart({required this.duration});
  @override
  String toString() => "Start { duration: $duration }";
}

class EventPause extends Event {}

class EventResume extends Event {}

class EventReset extends Event {}

class EventTick extends Event {
  final int duration;

  const EventTick({required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "Tick { duration: $duration }";
}
