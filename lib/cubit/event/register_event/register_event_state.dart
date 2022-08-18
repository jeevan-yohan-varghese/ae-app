part of 'register_event_cubit.dart';

abstract class RegisterEventState extends Equatable {
  const RegisterEventState();

  @override
  List<Object> get props => [];
}

class RegisterEventInitial extends RegisterEventState {}

class RegisterEventSuccess extends RegisterEventState {}

class RegisterEventFailed extends RegisterEventState {
  final String error;

  RegisterEventFailed({required this.error});
}
