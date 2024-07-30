import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repo.dart';
import '../data_sources/orders_data_source.dart';

class OrderRepoImpl extends OrderRepo {
  final OrdersDataSource orderDataSource;

  OrderRepoImpl({required this.orderDataSource});

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    try {
      final res = await orderDataSource.getOrders();
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, ServiceEntity>> getOrder(int orderId) async {
    try {
      final res = await orderDataSource.getOrder(orderId);
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError());
      }
    }
  }
}
