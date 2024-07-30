import 'package:car_rentting/Features/home/domain/entities/ad_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/api_service.dart';
import '../../../services/domain/entities/service_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<AdEntity>>> getAds();

  Future<Either<Failure, List<ServiceEntity>>> getCategory();

  Future<Either<Failure, List<ServiceEntity>>> getCategoryWithService();
}
