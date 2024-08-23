import 'package:dartz/dartz.dart';
import '../../../../core/utils/api_service.dart';
import '../entities/message_entity.dart';

abstract class PrivacyPolicyRepo {
  Future<Either<Failure, Message>> getPolicy();
  Future<Either<Failure, Message>> getWhoAreWe();
}
