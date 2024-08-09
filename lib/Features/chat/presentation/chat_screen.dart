import 'package:car_rentting/Features/chat/data/models/conversation_model.dart';
import 'package:car_rentting/Ui/shared_widget/custom_text_field.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../main.dart';
import '../../auth/presentation/manager/current_user_provider.dart';
import '../domain/use_case/chats_use_cases.dart';
import 'managers/get_chat_provider.dart';

class ChatPage extends ConsumerStatefulWidget {
  final int id;
  final bool? isDisabled;

  const ChatPage({super.key, required this.id, this.isDisabled = false});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  List<types.Message> _messages = [];
  late types.User _user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ref.watch(currentUserProvider)!;
    _user = types.User(id: user.userId.toString(), firstName: user.name);
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _loadMessagesFromResponse(ConversationModel conversation) {
    final messages = conversation.messages.map((e) {
      return types.TextMessage(
        author: types.User(id: e.userId.toString()),
        createdAt: e.createdAt.millisecondsSinceEpoch,
        id: e.id.toString(),
        showStatus: true,
        text: e.body,
        status: types.Status.sent,
      );
    }).toList();

    _messages = messages;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Chat with engineer".tr),
        ),
        body: Consumer(
          builder: (context, ref, _) {
            ref.listen(fetchConversationProvider(widget.id), (daf, sdfds) {
              if (sdfds.hasValue) {
                _loadMessagesFromResponse(sdfds.value!);
              }
            });
            final provider = ref.watch(fetchConversationProvider(widget.id));
            return provider.customWhen(
              ref: ref,
              refreshable: fetchConversationProvider(widget.id).future,
              skipLoadingOnRefresh: true,
              data: (conversation) {
                return SafeArea(
                  child: Chat(
                    messages: _messages,
                    // dateFormat: DateFormat.yMd().add_jm(),
                    // timeFormat: DateFormat.yMd().add_jm(),
                    // onAttachmentPressed: _handleAttachmentPressed,
                    // onMessageTap: _handleMessageTap,
                    onPreviewDataFetched: _handlePreviewDataFetched,
                    onSendPressed: (types.PartialText message) async {
                      final textMessage = types.TextMessage(
                        author: _user,
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                        id: const Uuid().v4(),
                        text: message.text,
                      );
                      await getIt<FetchSendMessageUseCase>().call(
                          Tuple2(conversation.order!.id, textMessage.text));
                      ref.invalidate(fetchConversationProvider(widget.id));
                      ref.invalidate(fetchChatRoomsProvider);
                    },
                    theme: DefaultChatTheme(
                        backgroundColor: Colors.white,
                        primaryColor: AppColors.primaryColorSALEK2,
                        secondaryColor: AppColors.primaryColorSALEK1,
                        receivedMessageBodyTextStyle:
                            TextStyle(color: AppColors.white, fontSize: 16.sp),
                        inputBackgroundColor:
                            AppColors.primaryColorSALEK2.withOpacity(.8),
                        inputSurfaceTintColor: AppColors.primaryColor),
                    // showUserAvatars: true,
                    showUserNames: true,
                    user: _user,
                    inputOptions: InputOptions(
                      enabled: !widget.isDisabled!,
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
}
