import 'package:car_rentting/Features/orders/domain/repositories/order_repo.dart';
import 'package:car_rentting/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/api_service.dart';
import '../entities/order_entity.dart';

class GetOrderUseCase extends UseCase<List<OrderEntity>, int> {
  final OrderRepo _orderRepository;

  GetOrderUseCase(this._orderRepository);

  @override
  Future<Either<Failure, List<OrderEntity>>> call([int ?param])async {
    return await _orderRepository.getOrders(param!);
   }


}
