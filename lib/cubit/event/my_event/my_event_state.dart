part of 'my_event_cubit.dart';

abstract class MyEventState extends Equatable {
  const MyEventState();

  @override
  List<Object> get props => [];
}

class MyEventInitial extends MyEventState {}

class MyEventSuccess extends MyEventState {
  final List<MyEvent> events;

  MyEventSuccess({required this.events});
}

class MyEventFailed extends MyEventState {
  final String error;

  MyEventFailed({required this.error});
}
