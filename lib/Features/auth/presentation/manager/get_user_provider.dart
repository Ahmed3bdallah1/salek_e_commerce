import 'package:car_rentting/Features/auth/domain/entities/user_entity.dart';
import 'package:car_rentting/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_rentting/Features/auth/domain/use_cases/fetch_user_data_use_case.dart';

final fetchUserDataProvider = FutureProvider<UserEntity>((ref) async {
  final user = await getIt<FetchUserDataUseCase>().call();
  return user.fold((l) {
    throw l;
  }, (r) {
    return (r);
  });
});
