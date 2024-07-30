import 'package:car_rentting/Features/services/domain/repositories/service_repo.dart';
import 'package:car_rentting/core/use_case/use_case.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';

class SubmitOrderUseCase extends UseCase<String?, (int, Map<String, dynamic>)> {
  final ServiceRepo _serviceRepository;

  SubmitOrderUseCase(this._serviceRepository);

  @override
  Future<Either<Failure, String?>> call(
      [(int, Map<String, dynamic>)? param]) async {
    return _serviceRepository.submitOrder(param!.$1, param.$2);
  }
}
