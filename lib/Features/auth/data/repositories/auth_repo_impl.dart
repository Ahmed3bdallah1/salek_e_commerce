import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:car_rentting/Features/auth/data/data_sources/auth_date_source.dart';
import 'package:car_rentting/Features/auth/data/models/login_request_model.dart';
import 'package:car_rentting/Features/auth/data/models/register_request_model.dart';
import 'package:car_rentting/Features/auth/domain/entities/login_entity.dart';
import 'package:car_rentting/Features/auth/domain/entities/user_entity.dart';
import 'package:car_rentting/Features/auth/domain/repositories/auth_repo.dart';
import 'package:car_rentting/Features/auth/presentation/manager/current_user_provider.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:car_rentting/main.dart';

import '../../../../core/utils/local_data_manager.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl(
    this.authDataSource,
    this.localDataManager,
  );

  final AuthDataSource authDataSource;
  final LocalDataManager localDataManager;

  @override
  Future<Either<Failure, LoginEntity>> login(
      LoginRequestModel requestModel) async {
    try {
      final res = await authDataSource.login(requestModel);
      await localDataManager.saveToken(res.token);
      await localDataManager.saveUser(res.user);

      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> register(
      RegisterRequestModel requestModel) async {
    try {
      final res = await authDataSource.register(requestModel);
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }

  @override
  Future<bool> logout() async {
    providerContainer.invalidate(currentUserProvider);
    await localDataManager.logout();
    return true;
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    final user = await authDataSource.getUserData();
    try {
      return Right(user);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword(
      Map<String, dynamic> data) async {
    try {
      await authDataSource.changePassword(data);

      return const Right(true);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccount() async {
    try {
      await authDataSource.deleteAccount();
      return const Right(true);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }
}
