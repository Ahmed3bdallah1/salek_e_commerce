import 'package:car_rentting/Features/auth/data/models/register_request_model.dart';
import 'package:car_rentting/Features/auth/data/models/user_model.dart';
import 'package:car_rentting/Features/auth/domain/repositories/auth_repo.dart';
import 'package:car_rentting/core/use_case/use_case.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:car_rentting/core/utils/local_data_manager.dart';
import 'package:car_rentting/main.dart';
import 'package:dartz/dartz.dart';

class UserRegisterUseCase extends UseCase<UserModel, RegisterRequestModel> {
  AuthRepo authRepo;

  UserRegisterUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserModel>> call([RegisterRequestModel? param]) async {
    final model = await authRepo.register(param!);
    return model.fold((l) async {
      return Left(l);
    }, (r) async {
      await getIt<LocalDataManager>().saveToken(r.token);
      await getIt<LocalDataManager>().saveUser(r.user);
      return Right(r.user);
    });
  }
}
