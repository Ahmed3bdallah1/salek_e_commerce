import 'package:car_rentting/Features/settings/data/data_source/policy_data_source.dart';
import 'package:car_rentting/core/utils/api_service.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/message_entity.dart';
import '../../domain/repo/policy_repo.dart';

class PrivacyPolicyRepoImp extends PrivacyPolicyRepo {
  final PrivacyPolicyDataSource privacyPolicyDataSource;

  PrivacyPolicyRepoImp({required this.privacyPolicyDataSource});

  @override
  Future<Either<Failure, Message>> getPolicy() async {
    try {
      final settings = await privacyPolicyDataSource.getPolicy();
      return Right(settings);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, Message>> getWhoAreWe() async {
    try {
      final settings = await privacyPolicyDataSource.getPolicy();
      return Right(settings);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }
}
