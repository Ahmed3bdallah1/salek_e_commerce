import 'package:car_rentting/Features/auth/presentation/manager/current_user_provider.dart';
import 'package:car_rentting/Features/auth/presentation/view/login_view.dart';
import 'package:car_rentting/Features/home/presentation/manager/root_index_provider.dart';
import 'package:car_rentting/Features/home/presentation/views/home_view.dart';
import 'package:car_rentting/Features/home/presentation/views/widgets/bottom_nav_bar_item.dart';
import 'package:car_rentting/Features/orders/presentation/View/orders_view.dart';
import 'package:car_rentting/Features/settings/presentation/View/profile_view.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../chat/presentation/chats_screen.dart';

class RootView extends ConsumerWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(rootIndexProvider);
    return Scaffold(
      body: [
        const HomeScreen(),
        // const AllCategories(),
        ref.watch(currentUserProvider) == null
            ? const YouMustLoginPage()
            : const OrdersView(),
        ref.watch(currentUserProvider) == null
            ? const YouMustLoginPage()
            : const ChatsScreen(),
        ref.watch(currentUserProvider) == null
            ? const YouMustLoginPage()
            : const SettingsView()
      ][currentIndex],
      bottomNavigationBar: Container(
        height: 90.h,
        // color: Colors.white,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xffE0E0E0))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BottomNavigationItem(
                  title: "Home".tr,
                  icon: Icons.home,
                  index: 0,
                ),
                // BottomNavigationItem(
                //   title: "Categories".tr,
                //   icon: Icons.table_rows,
                //   index: 1,
                // ),
                BottomNavigationItem(
                  title: "Orders".tr,
                  icon: Icons.history,
                  index: 1,
                ),
                BottomNavigationItem(
                  title: "Chats".tr,
                  icon: Icons.message,
                  index: 2,
                ),
                BottomNavigationItem(
                  title: "Settings".tr,
                  icon: Icons.settings,
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class YouMustLoginPage extends ConsumerWidget {
  const YouMustLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You must login to access this page".tr),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => const LoginView());
              },
              child: Text("Login".tr),
            )
          ],
        ),
      ),
    );
  }
}
