part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String jwt;
  final Participant participant;
  AuthSuccess({required this.jwt,required this.participant});
}

class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
   @override
  List<Object> get props => [error];
}
