import 'package:car_rentting/Features/home/data/data_sources/services_remote_data_source.dart';
import 'package:car_rentting/Features/home/domain/repos/services_repo.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../services/domain/entities/service_entity.dart';

class ServicesRepoImpl extends ServicesRepo {
  final ServicesDataSource dataSource;

  ServicesRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<ServiceEntity>>> getServices(
      int categoryId,[int type = 0]) async {
    try {
      final res = await dataSource.getServices(categoryId,type);
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError());
      }
    }
  }
}
