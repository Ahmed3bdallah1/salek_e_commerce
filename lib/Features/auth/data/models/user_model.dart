import 'package:car_rentting/Features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? emailVerifiedAt;
  int? roleId;
  String? permissions;
  String? createdAt;
  String? updatedAt;
  String? fcmToken;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      this.phone,
      this.emailVerifiedAt,
      this.roleId,
      this.permissions,
      this.createdAt,
      this.updatedAt,
      this.fcmToken})
      : super(
          userName: name ?? '',
          userEmail: email ?? '',
          userPhone: phone ?? '',
          userId: id ?? 0,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      emailVerifiedAt: json['email_verified_at'],
      roleId: json['role_id'],
      permissions: json['permissions'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      fcmToken: json['fcm_token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['email_verified_at'] = emailVerifiedAt;
    data['role_id'] = roleId;
    data['permissions'] = permissions;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['fcm_token'] = fcmToken;
    return data;
  }
}
