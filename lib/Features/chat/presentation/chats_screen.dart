import 'package:car_rentting/Features/categories/presentation/view/all_categories.dart';
import 'package:car_rentting/Features/chat/presentation/managers/get_chat_provider.dart';
import 'package:car_rentting/Features/chat/presentation/widgets/chat_room_container.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:car_rentting/core/utils/app_fonts.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../Ui/shared_widget/custom_error_widget.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this)
      ..addListener(() {
        ref.read(selectedTypeCategoryProvider.notifier).state =
            controller.index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor4,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor3,
        title: Text(
          "Chats".tr,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          controller: controller,
          dividerColor: AppColors.primaryColor1,
          isScrollable: false,
          tabs: [
            Tab(
              child: SizedBox(
                child: Center(
                  child: Text(
                    'Active'.tr,
                    style: AppFontStyle.black_18,
                  ),
                ),
              ),
            ),
            Tab(
              child: SizedBox(
                child: Center(
                  child: Text(
                    'Completed'.tr,
                    style: AppFontStyle.black_18,
                  ),
                ),
              ),
            )
          ],
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
                      return const Divider();
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
