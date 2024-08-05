import 'package:car_rentting/Features/categories/presentation/view/all_categories.dart';
import 'package:car_rentting/Features/home/domain/repos/home_repo.dart';
import 'package:car_rentting/Features/home/domain/repos/services_repo.dart';
import 'package:car_rentting/Features/home/domain/use_case/fetch_featured_category_use_case.dart';
import 'package:car_rentting/Features/home/domain/use_case/fetch_services_use_case.dart';
import 'package:car_rentting/main.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/domain/entities/service_entity.dart';

final fetchCategoriesProvider =
    FutureProvider.autoDispose<List<ServiceEntity>>((ref) async {
  final res =
      await FetchFeaturedCategoryUseCase(homeRepo: getIt<HomeRepo>()).call();
  return res.fold((l) => throw l, (r) => r);
});
final fetchCategoryWithServiceProvider =
    FutureProvider.autoDispose<List<ServiceEntity>>((ref) async {
  final res =
      await CategoryWithServiceUseCase(homeRepo: getIt<HomeRepo>()).call();
  return res.fold((l) => throw l, (r) => r);
});
final fetchServicesProvider = FutureProvider.family
    .autoDispose<List<ServiceEntity>, int>((ref, id) async {
  final res =
      await FetchServicesUseCase(servicesRepo: getIt<ServicesRepo>()).call(Tuple2(id,ref.watch(selectedTypeCategoryProvider)));
  return res.fold((l) => throw l, (r) => r);
});
