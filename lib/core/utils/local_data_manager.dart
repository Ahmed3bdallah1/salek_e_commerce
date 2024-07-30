import 'dart:convert';

import 'package:car_rentting/Features/auth/data/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

abstract class LocalDataManager {
  Future<void> saveToken(String token);

  Future<void> removeToken();

  // Future<void> setFCMToken(String? token);
  // String? getFCMToken();

  Future<void> saveUser(UserModel user);

  Future<void> logout();

  UserModel? getUser();

  String? getToken();
}

class LocalDataManagerImpl extends LocalDataManager {
  final GetStorage box = GetStorage();

  LocalDataManagerImpl();

  @override
  Future<void> saveToken(String token) async {
    await box.write('token', token);
  }

  @override
  String? getToken() {
    return box.read('token');
  }

  @override
  Future<void> removeToken() {
    return box.remove('token');
  }

  @override
  UserModel? getUser() {
    final res = box.read('user');
    if (res == null) {
      return null;
    } else {
      return UserModel.fromJson(jsonDecode(res));
    }
  }

  @override
  Future<void> saveUser(UserModel user) {
    return box.write('user', jsonEncode(user.toJson()));
  }

  @override
  Future<void> logout() {
    return box.erase();
  }

  // @override
  // String? getFCMToken() {
  //   return box.read('fcmToken');
  // }
  //
  // @override
  // Future<void> setFCMToken(String? token) {
  //   return box.write('fcmToken', token);
  // }
}
