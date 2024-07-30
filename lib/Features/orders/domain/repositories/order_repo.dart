import 'package:car_rentting/Features/orders/domain/entities/order_entity.dart';
import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';

abstract class OrderRepo {
  Future<Either<Failure, List<OrderEntity>>> getOrders();

  Future<Either<Failure, ServiceEntity>> getOrder(int orderId);
}
