import 'package:car_rentting/Features/chat/data/models/conversation_model.dart';
import 'package:car_rentting/Features/chat/domain/entities/chats_room_entity.dart';
import 'package:car_rentting/Features/chat/domain/repo/chats_repo.dart';
import 'package:car_rentting/Features/chat/domain/use_case/chats_use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../main.dart';

final fetchConversationProvider =
    FutureProvider.family.autoDispose<ConversationModel, int>((ref, id) async {
  final res = await FetchConversationUseCase(chatsRepo: getIt<ChatsRepo>()).call(id);
  return res.fold((l) => throw l, (r) => r);
});


final fetchChatRoomsProvider =
    FutureProvider.autoDispose<List<ChatsRoomEntity>>((ref) async {
  final res = await FetchChatRoomsUseCase(chatsRepo: getIt<ChatsRepo>()).call();
  return res.fold((l) => throw l, (r) => r);
});
