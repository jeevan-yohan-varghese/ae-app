import 'package:ae_task_app/data/models/participant.dart';

class LoginResponse {
  final bool success;
  final String jwt;
  final Participant participant;

  LoginResponse({
    required this.success,
    required this.jwt,
    required this.participant,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      participant: Participant.fromJson(json['user']),
      jwt: json['jwt'],
    );
  }
}


