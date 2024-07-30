import 'package:car_rentting/Features/auth/data/models/login_request_model.dart';
import 'package:car_rentting/Features/auth/data/models/register_request_model.dart';
import 'package:car_rentting/Features/auth/domain/entities/login_entity.dart';
import 'package:car_rentting/Features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/api_service.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginEntity>> register(
      RegisterRequestModel requestModel);

  Future<Either<Failure, LoginEntity>> login(LoginRequestModel requestModel);

  Future<bool> logout();

  Future<Either<Failure, UserEntity>> getUserData();
  Future<Either<Failure, bool>> deleteAccount();
  Future<Either<Failure, bool>> changePassword(Map<String, dynamic> data);
}
