class UserModel {
  final String userName;
  final String email;
  final String password;

  UserModel(
    {
      required this.userName,
      required this.email,
      required this.password,
    }
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'UserModel(userName: $userName, email: $email)';
  }
}