import 'package:car_rentting/Features/home/domain/entities/ad_entity.dart';
import 'package:car_rentting/Features/home/domain/repos/home_repo.dart';
import 'package:car_rentting/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/api_service.dart';

class FetchAdsUseCase extends UseCase<List<AdEntity>, NoParam> {
  final HomeRepo homeRepo;

  FetchAdsUseCase({
    required this.homeRepo,
  });

  @override
  Future<Either<Failure, List<AdEntity>>> call([void param]) {
    return homeRepo.getAds();
  }
}
