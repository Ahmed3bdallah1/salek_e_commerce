import 'package:car_rentting/Features/chat/data/models/conversation_model.dart';
import 'package:car_rentting/Features/chat/domain/entities/chats_room_entity.dart';
import 'package:car_rentting/Features/chat/domain/repo/chats_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../../core/utils/api_service.dart';

class FetchConversationUseCase extends UseCase<ConversationModel, int> {
  final ChatsRepo chatsRepo;

  FetchConversationUseCase({
    required this.chatsRepo,
  });

  @override
  Future<Either<Failure, ConversationModel>> call([int? param]) {
    return chatsRepo.getConversations(id: param ?? 0);
  }
}

class FetchChatRoomsUseCase extends UseCase<List<ChatsRoomEntity>,int> {
  final ChatsRepo chatsRepo;

  FetchChatRoomsUseCase({
    required this.chatsRepo,
  });

  @override
  Future<Either<Failure, List<ChatsRoomEntity>>> call([int? param]) {
    return chatsRepo.getChatRooms(param!);
  }
}

class FetchSendMessageUseCase extends UseCase<bool, Tuple2<int, String?>> {
  final ChatsRepo chatsRepo;

  FetchSendMessageUseCase({
    required this.chatsRepo,
  });

  @override
  Future<Either<Failure, bool>> call([Tuple2? param]) {
    return chatsRepo.sendMessage(id: param?.value1!, body: param?.value2!);
  }
}
