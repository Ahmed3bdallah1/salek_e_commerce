import 'package:car_rentting/Features/auth/domain/repositories/auth_repo.dart';
import 'package:car_rentting/Features/auth/presentation/view/login_view.dart';
import 'package:car_rentting/Features/settings/presentation/View/privacy_policy_screen.dart';
import 'package:car_rentting/Features/settings/presentation/View/user_profile_view.dart';
import 'package:car_rentting/Features/settings/presentation/View/widgets/setting_item_widget.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/const.dart';
import 'package:car_rentting/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
          child: Column(
            children: [
              SettingsItem(
                  onTap: () {
                    Get.to(() => const UserProfileView());
                  },
                  icon: Icons.lock,
                  title: 'Change Password'.tr),
              const SizedBox(height: Constants.spaceLarge),
              SettingsItem(
                  onTap: () {
                    Get.to(() => const PrivacyPolicyScreen());
                  },
                  icon: Icons.privacy_tip,
                  title: 'Privacy Policy'.tr),
              const SizedBox(height: Constants.spaceLarge),
              SettingsItem(
                  onTap: () async {
                    final res = await getIt<AuthRepo>().deleteAccount();
                    res.fold((l) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(l.message),
                      ));
                    }, (r) {
                      Get.offAll(() => const LoginView());
                    });
                  },
                  icon: Icons.delete,
                  title: 'Delete Account'.tr),
              const SizedBox(height: Constants.spaceLarge),
              SettingsItem(
                  onTap: () async {
                    await getIt<AuthRepo>().logout();
                    Get.offAll(() => const LoginView());
                  },
                  icon: Icons.logout,
                  title: 'Logout'.tr),
              const SizedBox(height: Constants.spaceLarge),
            ],
          ),
        ),
      ),
    );
  }
}
