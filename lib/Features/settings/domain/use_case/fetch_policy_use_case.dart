import 'package:car_rentting/Features/settings/data/models/policy_model.dart';
import 'package:car_rentting/Features/settings/domain/repo/policy_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/api_service.dart';

class FetchPolicyUseCase extends UseCase<Message, NoParam> {
  final PrivacyPolicyRepo policyRepo;

  FetchPolicyUseCase({required this.policyRepo});

  @override
  Future<Either<Failure, Message>> call([void param]) async {
    final res = await policyRepo.getPolicy();
    return res;
  }
}
