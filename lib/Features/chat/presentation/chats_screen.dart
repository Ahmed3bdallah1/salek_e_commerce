import 'package:car_rentting/Features/chat/presentation/managers/get_chat_provider.dart';
import 'package:car_rentting/Features/chat/presentation/widgets/chat_room_container.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../Ui/shared_widget/custom_error_widget.dart';

class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats".tr,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(fetchChatRoomsProvider.future),
        child: Consumer(
          builder: (context, ref, _) {
            final provider = ref.watch(fetchChatRoomsProvider);
            return provider.customWhen(
              ref: ref,
              refreshable: fetchChatRoomsProvider.future,
              skipLoadingOnRefresh: true,
              data: (chats) {
                if (chats.isEmpty) {
                  return EmptyWidget(
                    onRetry: () {
                      return ref.refresh(fetchChatRoomsProvider.future);
                    },
                  );
                }
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return ChatRoomContainer(chatsRoomEntity: chats[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10.h);
                    },
                    itemCount: chats.length);
              },
            );
          },
        ),
      ),
    );
  }
}
