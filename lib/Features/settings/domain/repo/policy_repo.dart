import 'package:car_rentting/Features/settings/data/models/policy_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/utils/api_service.dart';

abstract class PrivacyPolicyRepo {
  Future<Either<Failure, Message>> getPolicy();
}
