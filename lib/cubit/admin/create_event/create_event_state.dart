part of 'create_event_cubit.dart';

abstract class CreateEventState extends Equatable {
  const CreateEventState();

  @override
  List<Object> get props => [];
}

class CreateEventInitial extends CreateEventState {}

class CreateEventSuccess extends CreateEventState {}

class CreateEventError extends CreateEventState {
  final String error;
  CreateEventError({required this.error});
  @override
  List<Object> get props => [error];
}
