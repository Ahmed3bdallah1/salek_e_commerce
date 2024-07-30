import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/const.dart';
import '../model/settings_model.dart';

abstract class SettingsDataSource {
  Future<List<SettingItemModel>> getSettings();
}

class SettingsDataSourceImpl extends SettingsDataSource {
  final ApiService apiService;

  SettingsDataSourceImpl({required this.apiService});

  @override
  Future<List<SettingItemModel>> getSettings() async {
    final res = await apiService.get(
      url: GET_SETTINGS,
    );
    List<dynamic> data = res;

    final List<SettingItemModel> settingsList = data.map((e) {
      return SettingItemModel.fromJson(e);
    }).toList();

    return settingsList;
  }
}
