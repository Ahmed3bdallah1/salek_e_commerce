import 'package:car_rentting/Features/home/domain/repos/services_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/api_service.dart';
import '../../../services/domain/entities/service_entity.dart';

class FetchServicesUseCase extends UseCase<List<ServiceEntity>, Tuple2<int,int>> {
  final ServicesRepo servicesRepo;

  FetchServicesUseCase({
    required this.servicesRepo,
  });

  @override
  Future<Either<Failure, List<ServiceEntity>>> call([Tuple2? param]) {
    return servicesRepo.getServices(param?.value1!,param?.value2!);
  }
}
