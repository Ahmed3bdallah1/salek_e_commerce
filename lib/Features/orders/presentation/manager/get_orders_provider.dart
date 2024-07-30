import 'package:car_rentting/Features/orders/domain/entities/order_entity.dart';
import 'package:car_rentting/Features/orders/domain/use_cases/get_orders_use_case.dart';
import 'package:car_rentting/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getOrdersProvider =
    FutureProvider.autoDispose<List<OrderEntity>>((ref) async {
  return GetOrderUseCase(getIt())
      .call()
      .then((value) => value.fold((l) => throw l, (r) => r));
});
