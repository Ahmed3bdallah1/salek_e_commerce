import 'package:car_rentting/Features/chat/domain/entities/conversation_entity.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../../domain/entities/message_entity.dart';

class ConversationModel {
  final ConversationEntity conversations;
  final List<MessageEntity> messages;
  final OrderEntity? order;

  ConversationModel({
    required this.conversations,
    required this.messages,
    required this.order,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        conversations: ConversationEntity.fromJson(json["conversations"]),
        messages:  List<MessageEntity>.from(
            json["messages"].map((x) => MessageEntity.fromJson(x))),
        order:  OrderEntity.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "conversations": conversations.toJson(),
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "order": order!.toJson(),
      };
}
