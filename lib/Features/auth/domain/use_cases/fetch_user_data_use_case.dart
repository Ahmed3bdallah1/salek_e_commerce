import 'package:car_rentting/Features/auth/domain/entities/user_entity.dart';
import 'package:car_rentting/Features/auth/domain/repositories/auth_repo.dart';
import 'package:car_rentting/core/use_case/use_case.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';

class FetchUserDataUseCase extends UseCase<UserEntity, NoParam> {
  final AuthRepo authRepo;
  FetchUserDataUseCase({
    required this.authRepo,
  });

  @override
  Future<Either<Failure, UserEntity>> call([void param]) async {
    final res = await authRepo.getUserData();
    return res;
  }
}
