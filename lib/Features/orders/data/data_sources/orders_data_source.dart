import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:car_rentting/core/utils/api_service.dart';

import '../../../categories/data/models/category_model.dart';
import '../../domain/entities/order_entity.dart';
import '../models/order_model.dart';

abstract class OrdersDataSource {
  Future<List<OrderEntity>> getOrders(int type);

  Future<ServiceEntity> getOrder(int id);
}

class OrdersDataSourceImpl implements OrdersDataSource {
  ApiService apiService;

  OrdersDataSourceImpl(this.apiService);

  @override
  Future<List<OrderEntity>> getOrders(int type) async {
    final orders = await apiService.get<List>(url: 'getOrder/for/user',queryParameters: {
      'type': type
    });
    return orders.map((e) => OrderModel.fromJson(e)).toList();
  }

  @override
  Future<ServiceEntity> getOrder(int id) async {
    final orders = await apiService.get(url: 'getOrder/$id');
    return CategoryModel.fromJson(orders);
  }
}
