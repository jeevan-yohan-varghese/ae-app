
class GeneralResponse {
  final bool success;
  final String message;

  GeneralResponse({
    required this.success,
    required this.message,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) {
    return GeneralResponse(
      success: json['success'],
      message: json['message']
      
    );
  }
}


