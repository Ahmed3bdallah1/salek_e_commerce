import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';

class OrderEntity {
  final int id;

  final DateTime date;
  final ServiceEntity service;

  OrderEntity({
    required this.id,
    required this.date,
    required this.service,
  });
}
