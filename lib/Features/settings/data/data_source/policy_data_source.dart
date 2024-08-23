import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/const.dart';
import '../../domain/entities/message_entity.dart';

abstract class PrivacyPolicyDataSource {
  Future<Message> getPolicy();
  Future<Message> getWhoAreWe();
}

class PrivacyPolicyDataSourceImpl extends PrivacyPolicyDataSource {
  final ApiService apiService;

  PrivacyPolicyDataSourceImpl({required this.apiService});

  @override
  Future<Message> getPolicy() async {
    final res = await apiService.get(url: GET_TERMS, returnDataOnly: false);

    final Message privacyPolicyModel =
        Message.fromJson((res['message'] as List).first);

    return privacyPolicyModel;
  }

  @override
  Future<Message> getWhoAreWe() async {
    final res = await apiService.get(url: GET_TERMS, returnDataOnly: false);

    final Message privacyPolicyModel =
    Message.fromJson((res['message'] as List).first);

    return privacyPolicyModel;
  }
}
