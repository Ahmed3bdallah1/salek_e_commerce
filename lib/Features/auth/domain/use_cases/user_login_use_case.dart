import 'package:car_rentting/Features/auth/data/models/user_model.dart';
import 'package:car_rentting/Features/auth/domain/repositories/auth_repo.dart';
import 'package:car_rentting/core/use_case/use_case.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/login_request_model.dart';

class UserLoginUseCase extends UseCase<UserModel, LoginRequestModel> {
  AuthRepo authRepo;

  UserLoginUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserModel>> call([LoginRequestModel? param]) async {
    final model = await authRepo.login(param!);
    return model.fold((l) {
      return Left(l);
    }, (r) {
      return Right(r.user);
    });
  }
}
