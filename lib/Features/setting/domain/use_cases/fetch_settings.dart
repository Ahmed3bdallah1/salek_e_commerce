import 'package:car_rentting/Features/setting/domain/repositories/settings_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/api_service.dart';
import '../../data/model/settings_model.dart';

class FetchSettingsUseCase extends UseCase<List<SettingItemModel>, NoParam> {
  final SettingsRepo settingsRepo;

  FetchSettingsUseCase({required this.settingsRepo});

  @override
  Future<Either<Failure, List<SettingItemModel>>> call([void param]) async {
    final res = await settingsRepo.getSettings();
    return res;
  }
}
