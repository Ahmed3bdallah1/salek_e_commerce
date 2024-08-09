import 'package:car_rentting/Features/chat/data/models/conversation_model.dart';
import 'package:car_rentting/Features/chat/domain/entities/chats_room_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/api_service.dart';

abstract class ChatsRepo {
  Future<Either<Failure, bool>> sendMessage(
      {required int id, required String body});

  Future<Either<Failure, ConversationModel>> getConversations(
      {required int id});

  Future<Either<Failure, List<ChatsRoomEntity>>> getChatRooms(int status);
}
