import 'dart:convert';

import 'package:car_rentting/Features/categories/data/models/category_model.dart';

import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/const.dart';
import '../../domain/entities/service_entity.dart';

// enum PaymentType {
//   online({'payway': "online"}),
//   cash({});
//
//   final Map<String, dynamic> val;
//   const PaymentType(this.val);
// }

abstract class ServiceDataSource {
  Future<ServiceEntity> getService(int id);

  Future<String?> submitOrder(int id, Map<String, dynamic> data);
}

class ServiceDataSourceImpl extends ServiceDataSource {
  final ApiService apiService;

  ServiceDataSourceImpl({required this.apiService});

  @override
  Future<ServiceEntity> getService(int id) async {
    final res = await apiService.get(url: "$GET_SERVICE/$id");
    final fields = CategoryModel.fromJson(res);
    return fields;
  }

  @override
  Future<String?> submitOrder(int id, Map<String, dynamic> data) async {
    final res = await apiService.post(url: "storeOrderForm", requestBody: {
      "service_id": id,
      "form": jsonEncode(data.entries
          .map((e) => {"field_id": e.key.toString(), "value": e.value})
          .where((element) => element['value'] != null)
          .toList())
    });
    return res;
  }
}
