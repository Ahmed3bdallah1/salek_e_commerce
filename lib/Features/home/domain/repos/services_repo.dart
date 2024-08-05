import 'package:car_rentting/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';

import '../../../services/domain/entities/service_entity.dart';

abstract class ServicesRepo {
  Future<Either<Failure, List<ServiceEntity>>> getServices(int categoryId,[int type = 0]);
}
