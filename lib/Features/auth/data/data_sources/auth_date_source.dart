import 'package:car_rentting/Features/auth/data/models/register_request_model.dart';
import 'package:car_rentting/Features/auth/data/models/update_password_model.dart';
import 'package:car_rentting/Features/auth/data/models/user_model.dart';
import 'package:car_rentting/Features/auth/domain/entities/login_entity.dart';
import 'package:car_rentting/Features/auth/domain/entities/user_entity.dart';
import 'package:car_rentting/core/utils/const.dart';

import '../../../../core/utils/api_service.dart';
import '../models/login_request_model.dart';

abstract class AuthDataSource {
  Future<LoginEntity> register(RegisterRequestModel requestModel);

  Future<LoginEntity> login(LoginRequestModel requestModel);
  Future<UserEntity> getUserData();
  Future<bool> deleteAccount();
  Future<UpdatePasswordModel> changePassword(Map<String, dynamic> data);
}

class AuthDataSourceImpl extends AuthDataSource {
  final ApiService apiService;

  AuthDataSourceImpl({required this.apiService});

  @override
  Future<LoginEntity> login(LoginRequestModel requestModel) async {
    final res = await apiService.post(
        url: LOGIN, requestBody: requestModel.toJson(), returnDataOnly: false);
    return LoginEntity.fromJson(res);
  }

  @override
  Future<LoginEntity> register(RegisterRequestModel requestModel) async {
    final res = await apiService.post(
        url: REGISTER,
        requestBody: requestModel.toJson(),
        returnDataOnly: false);
    return LoginEntity.fromJson(res);
  }

  @override
  Future<UserEntity> getUserData() async {
    //TODO
    final user =
        await apiService.get(url: GET_USER_DATA, returnDataOnly: false);
    return UserModel.fromJson(user);
  }

  @override
  Future<UpdatePasswordModel> changePassword(Map<String, dynamic> data) async {
    final res = await apiService.post(
      url: CHANGE_PASSWORD,
      requestBody: data,
    );
    return UpdatePasswordModel.fromJson(res);
  }

  @override
  Future<bool> deleteAccount() async {
    await apiService.get(
      url: DELETE_ACCOUNT,
    );
    return true;
  }
}
