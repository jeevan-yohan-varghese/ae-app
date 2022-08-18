part of 'get_event_cubit.dart';

abstract class GetEventState extends Equatable {
  const GetEventState();

  @override
  List<Object> get props => [];
}

class GetEventInitial extends GetEventState {}

class GetEventLoading extends GetEventState {}

class GetEventSuccess extends GetEventState {
  final List<Event> events;

  GetEventSuccess({required this.events});
}

class GetEventFailed extends GetEventState {
  final String error;

  GetEventFailed({required this.error});
}
