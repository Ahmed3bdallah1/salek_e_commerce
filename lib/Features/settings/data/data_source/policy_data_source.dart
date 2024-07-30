import 'package:car_rentting/Features/settings/data/models/policy_model.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/const.dart';

abstract class PrivacyPolicyDataSource {
  Future<Message> getPolicy();
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
}
