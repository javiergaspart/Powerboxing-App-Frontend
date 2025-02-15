class UserModel {
  final String id;
  final String name;
  final String email;
  final int sessionBalance;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.sessionBalance,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      sessionBalance: json['session_balance'] ?? 1,
      role: json['role'],
    );
  }
}
