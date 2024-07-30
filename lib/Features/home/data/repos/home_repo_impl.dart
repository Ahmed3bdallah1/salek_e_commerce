import 'package:car_rentting/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:car_rentting/Features/home/domain/entities/ad_entity.dart';
import 'package:car_rentting/Features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/api_service.dart';
import '../../../services/domain/entities/service_entity.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeDataSource dataSource;

  HomeRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<AdEntity>>> getAds() async {
    try {
      final res = await dataSource.getAds();
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, List<ServiceEntity>>> getCategory() async {
    try {
      final res = await dataSource.getCategory();
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, List<ServiceEntity>>> getCategoryWithService() async {
    try {
      final res = await dataSource.getCategoryWithService();
      return right(
        res..removeWhere((element) => element.subCategories.isEmpty),
      );
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError());
      }
    }
  }
}
