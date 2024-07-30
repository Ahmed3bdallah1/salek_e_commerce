import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';

abstract class ServiceRepo {
  Future<Either<Failure, ServiceEntity>> getService(int id);

  Future<Either<Failure, String?>> submitOrder(
      int serviceId, Map<String, dynamic> data);
}
