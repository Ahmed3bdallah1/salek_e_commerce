import 'package:car_rentting/gen/assets.gen.dart';

class ChatsRoomEntity {
  final int id;
  final String title;
  final String photo;
  final int userId;
  final int servicesId;
  final int status;
  final int sendTo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic payway;
  final String price;
  final String discount;
  final String total;
  final String lastMessage;
  final DateTime lastMessageTime;

  ChatsRoomEntity({
    required this.id,
    required this.title,
    required this.photo,
    required this.userId,
    required this.servicesId,
    required this.status,
    required this.sendTo,
    required this.createdAt,
    required this.updatedAt,
    required this.payway,
    required this.price,
    required this.discount,
    required this.total,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory ChatsRoomEntity.fromJson(Map<String, dynamic> json) =>
      ChatsRoomEntity(
        id: json["id"],
        title: json['titleAr'],
        photo: json['photo'],
        userId: json["user_id"],
        servicesId: json["services_id"],
        status: json["status"],
        sendTo: json["send_to"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        payway: json["payway"],
        price: json["price"],
        discount: json["discount"],
        total: json["total"],
        lastMessage: json["lastMessage"],
        lastMessageTime: DateTime.parse(json["lastMessageTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "photo": photo,
        "user_id": userId,
        "services_id": servicesId,
        "status": status,
        "send_to": sendTo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "payway": payway,
        "price": price,
        "discount": discount,
        "total": total,
        "lastMessage": lastMessage,
        "lastMessageTime": lastMessageTime.toIso8601String(),
      };
}
