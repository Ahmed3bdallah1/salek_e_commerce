import 'package:car_rentting/Features/auth/domain/repositories/auth_repo.dart';
import 'package:car_rentting/core/use_case/use_case.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';

//TODO
class UpdatePasswordUseCase extends UseCase<bool, Map<String, dynamic>> {
  AuthRepo authRepo;

  UpdatePasswordUseCase({
    required this.authRepo,
  });

  @override
  Future<Either<Failure, bool>> call([Map<String, dynamic>? param]) async {
    final model = await authRepo.changePassword(param!);
    return model;
  }
}
