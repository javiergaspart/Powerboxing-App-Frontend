class UserModel {
  final String id;
  final String username;
  final String email;
  final int sessionBalance;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.sessionBalance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      sessionBalance: json['sessionBalance'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'sessionBalance': sessionBalance,
    };
  }

  UserModel copyWith({int? sessionBalance}) {
    return UserModel(
      id: id,
      username: username,
      email: email,
      sessionBalance: sessionBalance ?? this.sessionBalance,
    );
  }

  static UserModel defaultUser() {
    return UserModel(
      id: '0',
      username: 'Guest',
      email: 'guest@example.com',
      sessionBalance: 0,
    );
  }
}



