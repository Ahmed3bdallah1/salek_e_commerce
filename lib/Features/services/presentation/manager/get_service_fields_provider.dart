import 'package:car_rentting/Features/orders/domain/use_cases/get_single_order_use_case.dart';
import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:car_rentting/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_cases/get_service_use_case.dart';

final getServiceFieldsProvider = FutureProvider.autoDispose
    .family<ServiceEntity, int>((ref, serviceId) async {
  final res = await GetServiceUseCase(getIt())(serviceId);
  return res.fold((l) => throw l, (r) => r);
});

final getPastServiceFieldsProvider =
    FutureProvider.autoDispose.family<ServiceEntity, int>((ref, orderId) async {
  final res = await GetSingleOrderUseCase(getIt())(orderId);
  return res.fold((l) => throw l, (r) => r);
});
