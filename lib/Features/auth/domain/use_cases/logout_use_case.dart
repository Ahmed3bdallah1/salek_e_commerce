import 'package:car_rentting/Features/auth/domain/repositories/auth_repo.dart';

class LogoutUseCase {
  final AuthRepo authRepo;

  LogoutUseCase(this.authRepo);

  Future<bool> execute() async {
    return await authRepo.logout();
  }
}
