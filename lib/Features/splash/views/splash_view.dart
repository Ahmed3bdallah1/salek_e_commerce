import 'package:car_rentting/Features/auth/presentation/view/login_view.dart';
import 'package:car_rentting/Features/home/presentation/views/root_view.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:car_rentting/core/widgets/logo_widget.dart';
import 'package:car_rentting/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../core/utils/local_data_manager.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    ref.watch(splashProvider);
    return Scaffold(
      backgroundColor: AppColors.primaryColorSALEK2,
      body: ScaleTransition(
        scale: _animation,
        child: const Center(child: LogoWidget()),
      ),
    );
  }
}

final splashNavigateProvider = Provider.autoDispose<SplashNavigate>((ref) {
  SplashNavigate splashNavigate = SplashNavigate.home;
  final dataManager = getIt<LocalDataManager>();
  if (dataManager.getToken() != null) {
    splashNavigate = SplashNavigate.home;
  } else {
    splashNavigate = SplashNavigate.login;
  }

  switch (splashNavigate) {
    case SplashNavigate.home:
      Get.off(() => const RootView());
      break;
    case SplashNavigate.login:
      Get.off(() => const LoginView());
      break;
  }
  return splashNavigate;
});

final splashProvider = FutureProvider.autoDispose<bool>((ref) async {
  await Future.delayed(const Duration(seconds: 3));
  ref.read(splashNavigateProvider);
  return true;
});

enum SplashNavigate {
  home,
  login,
}
