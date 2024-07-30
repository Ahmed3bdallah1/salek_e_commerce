import 'package:dartz/dartz.dart';
import '../../../../core/utils/api_service.dart';
import '../../data/model/settings_model.dart';

abstract class SettingsRepo {
  Future<Either<Failure, List<SettingItemModel>>> getSettings();
}
