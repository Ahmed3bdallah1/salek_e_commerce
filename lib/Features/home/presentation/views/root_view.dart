import 'package:car_rentting/Features/auth/presentation/manager/current_user_provider.dart';
import 'package:car_rentting/Features/auth/presentation/view/login_view.dart';
import 'package:car_rentting/Features/home/presentation/manager/root_index_provider.dart';
import 'package:car_rentting/Features/home/presentation/views/home_view.dart';
import 'package:car_rentting/Features/home/presentation/views/widgets/bottom_nav_bar_item.dart';
import 'package:car_rentting/Features/orders/presentation/View/orders_view.dart';
import 'package:car_rentting/Features/settings/presentation/View/profile_view.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../chat/presentation/chats_screen.dart';

class RootView extends ConsumerWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(rootIndexProvider);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFFEDE7F6), // A light lavender color
                  Color(0xFFB3E5FC) // A soft light blue color
                ],
              ),
            ),
          ),
          [
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
          ][currentIndex]
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFFEDE7F6), // A light lavender color
              Color(0xFFB3E5FC) // A soft light blue color
            ],
          ),
        ),
        child: ConvexAppBar(
          style: TabStyle.react,
          activeColor: Colors.black,
          color: Colors.black,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFFEDE7F6), // A light lavender color
              Color(0xFFB3E5FC) // A soft light blue color
            ],
          ),
          onTap: (index) {
            ref.read(rootIndexProvider.notifier).state = index;
          },
          initialActiveIndex: currentIndex,
          items: [
            TabItem(
              title: ("Home".tr),
              icon: Icon(Icons.home),
            ),
            TabItem(
              title: ("Orders".tr),
              icon: Icon(Icons.history),
            ),
            TabItem(
              title: ("Chats".tr),
              icon: Icon(Icons.message),
            ),
            TabItem(
              title: ("Settings".tr),
              icon: Icon(Icons.settings),
            ),
          ],
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
      backgroundColor: Colors.transparent,
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
