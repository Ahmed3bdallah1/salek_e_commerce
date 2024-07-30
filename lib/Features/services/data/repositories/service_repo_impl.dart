import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/service_repo.dart';
import '../data_sources/service_data_source.dart';

class ServiceRepoImpl extends ServiceRepo {
  final ServiceDataSource servicesDataSource;

  ServiceRepoImpl(this.servicesDataSource);

  @override
  Future<Either<Failure, ServiceEntity>> getService(int id) async {
    try {
      final res = await servicesDataSource.getService(id);
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
  Future<Either<Failure, String?>> submitOrder(
      int serviceId, Map<String, dynamic> data) async {
    try {
      final res = await servicesDataSource.submitOrder(serviceId, data);
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }
}
