import 'package:car_rentting/Features/categories/data/models/category_model.dart';
import 'package:car_rentting/Features/home/data/models/ad_model.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:car_rentting/core/utils/const.dart';

import '../../../services/domain/entities/service_entity.dart';
import '../../domain/entities/ad_entity.dart';

abstract class HomeDataSource {
  Future<List<AdEntity>> getAds();

  Future<List<ServiceEntity>> getCategory();

  Future<List<ServiceEntity>> getCategoryWithService();
}

class HomeDataSourceImpl extends HomeDataSource {
  ApiService apiService;

  HomeDataSourceImpl(this.apiService);

  @override
  Future<List<AdEntity>> getAds() async {
    final ads = await apiService.get<List>(url: GET_SLIDER);
    return ads.map((e) => AdModel.fromJson(e)).toList();
  }

  @override
  Future<List<ServiceEntity>> getCategory() async {
    final cat = await apiService.get<List>(url: GET_CATEGORIES);
    return cat.map((e) => CategoryModel.fromJson(e)).toList();
  }

  @override
  Future<List<ServiceEntity>> getCategoryWithService() async {
    final cat = await apiService.get<List>(url: GET_CATEGORY_WITH_SERVICE);
    return cat.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
