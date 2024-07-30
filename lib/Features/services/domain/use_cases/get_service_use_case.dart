import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:car_rentting/Features/services/domain/repositories/service_repo.dart';
import 'package:car_rentting/core/use_case/use_case.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';

class GetServiceUseCase extends UseCase<ServiceEntity, int> {
  final ServiceRepo _serviceRepository;

  GetServiceUseCase(this._serviceRepository);

  @override
  Future<Either<Failure, ServiceEntity>> call([int? param]) {
    return _serviceRepository.getService(param!);
  }
}
