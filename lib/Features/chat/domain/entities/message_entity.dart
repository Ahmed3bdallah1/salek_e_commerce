import 'conversation_entity.dart';

class MessageEntity {
  final int id;
  final int userId;
  final int conversationId;
  final String body;
  final int isSeen;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ConversationEntity conversation;

  MessageEntity({
    required this.id,
    required this.userId,
    required this.conversationId,
    required this.body,
    required this.isSeen,
    required this.createdAt,
    required this.updatedAt,
    required this.conversation,
  });

  factory MessageEntity.fromJson(Map<String, dynamic> json) => MessageEntity(
    id: json["id"],
    userId: json["user_id"],
    conversationId: json["conversation_id"],
    body: json["body"],
    isSeen: json["is_seen"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    conversation: ConversationEntity.fromJson(json["conversation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "conversation_id": conversationId,
    "body": body,
    "is_seen": isSeen,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "conversation": conversation.toJson(),
  };
}