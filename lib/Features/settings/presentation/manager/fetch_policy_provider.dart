import 'package:car_rentting/Features/settings/domain/use_case/fetch_policy_use_case.dart';
import 'package:car_rentting/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/message_entity.dart';

final fetchPolicyProvider = FutureProvider.autoDispose<Message>((ref) async {
  final res = await getIt<FetchPolicyUseCase>().call();
  return res.fold((l) => throw l, (r) => r);
});


final fetchWhoAreWeProvider = FutureProvider.autoDispose<Message>((ref) async {
  final res = await getIt<FetchWhoAreWeUseCase>().call();
  return res.fold((l) => throw l, (r) => r);
});
