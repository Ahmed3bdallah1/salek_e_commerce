import 'package:car_rentting/Features/setting/data/data_source/settings_data_source.dart';
import 'package:car_rentting/Features/setting/domain/repositories/settings_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/api_service.dart';
import '../model/settings_model.dart';

class SettingsRepoImp extends SettingsRepo {
  final SettingsDataSource settingsDataSource;

  SettingsRepoImp({required this.settingsDataSource});

  @override
  Future<Either<Failure, List<SettingItemModel>>> getSettings() async {
    try {
      final settings = await settingsDataSource.getSettings();
      return Right(settings);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError());
      }
    }
  }
}
