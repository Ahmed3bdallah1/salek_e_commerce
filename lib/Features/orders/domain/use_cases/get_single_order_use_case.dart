import 'package:car_rentting/Features/orders/domain/repositories/order_repo.dart';
import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:car_rentting/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/api_service.dart';

class GetSingleOrderUseCase extends UseCase<ServiceEntity, int> {
  final OrderRepo _orderRepository;

  GetSingleOrderUseCase(this._orderRepository);

  @override
  Future<Either<Failure, ServiceEntity>> call([int? param]) {
    return _orderRepository.getOrder(param!);
  }
}
