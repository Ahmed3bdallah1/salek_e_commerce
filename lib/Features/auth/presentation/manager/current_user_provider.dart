import 'package:car_rentting/Features/auth/data/models/user_model.dart';
import 'package:car_rentting/core/utils/local_data_manager.dart';
import 'package:car_rentting/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = StateProvider<UserModel?>((ref) {
  return getIt<LocalDataManager>().getUser();
});
