import 'package:car_rentting/Features/chat/data/data_source/chats_data_source.dart';
import 'package:car_rentting/Features/chat/data/models/conversation_model.dart';
import 'package:car_rentting/Features/chat/domain/repo/chats_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/api_service.dart';
import '../../domain/entities/chats_room_entity.dart';

class ChatsRepoImpl extends ChatsRepo {
  final ChatsDataSource dataSource;

  ChatsRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> sendMessage(
      {required int id, required String body}) async {
    try {
      final res = await dataSource.sendMessage(id: id, body: body);
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, ConversationModel>> getConversations(
      {required int id}) async {
    try {
      final res = await dataSource.getConversation(id: id);
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError());
      }
    }
  }

  @override
  Future<Either<Failure, List<ChatsRoomEntity>>> getChatRooms(int status) async {
    try {
      final res = await dataSource.getConversationsList(status);
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(GeneralError());
      }
    }
  }
}
