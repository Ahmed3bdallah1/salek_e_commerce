import 'package:car_rentting/Features/chat/data/models/conversation_model.dart';
import 'package:car_rentting/Features/chat/domain/entities/chats_room_entity.dart';
import 'package:car_rentting/core/utils/const.dart';

import '../../../../core/utils/api_service.dart';

abstract class ChatsDataSource {
  Future<ConversationModel> getConversation({required int id});

  Future<List<ChatsRoomEntity>> getConversationsList(int status);

  Future<bool> sendMessage({required int id, required String body});
}

class ChatsDataSourceImpl extends ChatsDataSource {
  ApiService apiService;

  ChatsDataSourceImpl(this.apiService);

  @override
  Future<ConversationModel> getConversation({required int id}) async {
    final conversation =
        await apiService.get(url: "$GET_CONVERSATION/$id", returnDataOnly: false);
    return ConversationModel.fromJson(conversation);
  }

  @override
  Future<bool> sendMessage({required int id, required String body}) async {
    await apiService
        .post(url: SEND_MESSAGE, requestBody: {"body": body, "order_id": id});
    return true;
  }

  @override
  Future<List<ChatsRoomEntity>> getConversationsList(int status) async {
    final conversations = await apiService.get<List>(url: GET_CHATS,queryParameters: {
      "status": status
    });
    return conversations.map((e) => ChatsRoomEntity.fromJson(e)).toList();
  }
}
