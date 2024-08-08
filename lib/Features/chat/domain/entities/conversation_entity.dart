class ConversationEntity {
  final int id;
  final int customer;
  final int engineer;
  final int orderId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConversationEntity({
    required this.id,
    required this.customer,
    required this.engineer,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConversationEntity.fromJson(Map<String, dynamic> json) => ConversationEntity(
    id: json["id"],
    customer: json["customer"],
    engineer: json["engineer"],
    orderId: json["order_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer": customer,
    "engineer": engineer,
    "order_id": orderId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}