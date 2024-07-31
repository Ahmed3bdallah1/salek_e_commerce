class RegisterRequestModel {
  String name;
  String email;
  String password;
  String phone;
  String company;
  String address;
  String? fcmToken;

  RegisterRequestModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.company,
      required this.address,
      required this.password,
      required this.fcmToken});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      "company": company,
      "address": address,
      'password': password,
      'fcm_token': fcmToken
    };
  }
}
