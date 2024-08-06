import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';

class OrderEntity {
  final int id;
  final int? status;
  final DateTime date;
  final ServiceEntity ?service;

  OrderEntity({
    this.status,
    required this.id,
    required this.date,
    required this.service,
  });

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    return OrderEntity(
      id: json['id'],
      status: json['status'],
      date: DateTime.parse(json['created_at']),
      service:json['service'] == null?null: ServiceEntity.fromJson(json['service']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'date': date.toIso8601String(),
      'service': service?.toJson(),
    };
  }
}
