import 'package:car_rentting/Features/home/domain/repos/home_repo.dart';
import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:car_rentting/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/api_service.dart';

class FetchFeaturedCategoryUseCase
    extends UseCase<List<ServiceEntity>, NoParam> {
  final HomeRepo homeRepo;

  FetchFeaturedCategoryUseCase({
    required this.homeRepo,
  });

  @override
  Future<Either<Failure, List<ServiceEntity>>> call([void param]) {
    return homeRepo.getCategory();
  }
}

class CategoryWithServiceUseCase extends UseCase<List<ServiceEntity>, NoParam> {
  final HomeRepo homeRepo;

  CategoryWithServiceUseCase({
    required this.homeRepo,
  });

  @override
  Future<Either<Failure, List<ServiceEntity>>> call([void param]) {
    return homeRepo.getCategoryWithService();
  }
}
