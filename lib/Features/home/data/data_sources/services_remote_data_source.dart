import 'package:car_rentting/Features/categories/data/models/category_model.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:car_rentting/core/utils/const.dart';

import '../../../services/domain/entities/service_entity.dart';

abstract class ServicesDataSource {
  Future<List<ServiceEntity>> getServices(int categoryId,[int type = 0]);
}

class ServicesDataSourceImpl extends ServicesDataSource {
  ApiService apiService;

  ServicesDataSourceImpl(this.apiService);

  @override
  Future<List<ServiceEntity>> getServices(int categoryId,[int type = 0]) async {
    final cat = await apiService.get<List>(url: '$GET_SERVICES/$categoryId',queryParameters: {
      'type' : type
    });
    return cat.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
