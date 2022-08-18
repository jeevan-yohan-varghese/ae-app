class Participant {
  final String name;
  final String email;
  final String regNo;
  final String pid;

  Participant({
    required this.name,
    required this.email,
    required this.regNo,
    required this.pid,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
        name: json['name'],
        email: json['email'],
        regNo: json['regNo'],
        pid: json['pid']);
  }
}
