import '../../../categories/data/models/category_model.dart';
import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  int? orderId;
  int? userId;
  int? servicesId;
  int? status;
  String? createdAt;
  String? updatedAt;
  CategoryModel? services;

  OrderModel(
      {this.orderId,
      this.userId,
      this.servicesId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.services})
      : super(
            id: orderId!, date: DateTime.parse(createdAt!), service: services!);

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['id'],
      userId: json['user_id'],
      servicesId: json['services_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      services: CategoryModel.fromJson(json['services']),
    );
  }
}
