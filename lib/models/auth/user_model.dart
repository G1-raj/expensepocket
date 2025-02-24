class UserModel {
  final String userName;
  final String email;
  final String password;
  final String mobileNo;

  UserModel(
    {
      required this.userName,
      required this.email,
      required this.password,
      required this.mobileNo,
    }
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      mobileNo: json['mobileNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'password': password,
      'mobileNo': mobileNo,
    };
  }

  @override
  String toString() {
    return 'UserModel(userName: $userName, email: $email, mobileNo: $mobileNo)';
  }
}