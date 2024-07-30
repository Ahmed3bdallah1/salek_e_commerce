import 'package:car_rentting/Features/home/domain/entities/ad_entity.dart';
import 'package:car_rentting/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repos/home_repo.dart';
import '../../domain/use_case/fetch_ads_use_case.dart';

final fetchAdsProvider =
    FutureProvider.autoDispose<List<AdEntity>>((ref) async {
  final res = await FetchAdsUseCase(homeRepo: getIt<HomeRepo>()).call();
  return res.fold((l) => throw l, (r) => r);
});
