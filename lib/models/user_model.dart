// lib/models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final int sessionBalance;

  UserModel({required this.id, required this.name, required this.email, required this.sessionBalance});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      sessionBalance: json['session_balance'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'email': email, 'session_balance': sessionBalance};
  }
}
