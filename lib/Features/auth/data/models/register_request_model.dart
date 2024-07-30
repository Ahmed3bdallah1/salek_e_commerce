class RegisterRequestModel {
  String name;
  String email;
  String password;
  String phone;
  String? fcmToken;

  RegisterRequestModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.fcmToken});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'fcm_token': fcmToken
    };
  }
}
