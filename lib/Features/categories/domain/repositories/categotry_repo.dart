import 'package:dartz/dartz.dart';

import '../../../../core/utils/api_service.dart';
import '../../../services/domain/entities/service_entity.dart';

abstract class CategoryRepo {
  Future<Either<Failure, List<ServiceEntity>>> getCategories();
}
