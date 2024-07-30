import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../main.dart';
import '../../data/model/settings_model.dart';
import '../../domain/use_cases/fetch_settings.dart';

final fetchSettingsProvider =
    FutureProvider<List<SettingItemModel>>((ref) async {
  final settings = await getIt<FetchSettingsUseCase>().call();

  return settings.fold((l) {
    throw l;
  }, (r) {
    return r;
  });
});
