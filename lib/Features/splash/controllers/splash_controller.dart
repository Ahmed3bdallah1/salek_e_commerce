// import 'package:car_rentting/Features/home/presentation/views/home_drawer.dart';
// import 'package:car_rentting/Features/profile/domain/entities/user_entity.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';

// enum SplashNavigate { home, login, language }

// final splashNavigateProvider = Provider.autoDispose<SplashNavigate>((ref) {
//   SplashNavigate splashNavigate = SplashNavigate.home;
//   // if (dataManager.getToken() != null) {
//   //   splashNavigate = SplashNavigate.home;
//   // } else if (dataManager.isFirstTime) {
//   //   splashNavigate = SplashNavigate.language;
//   // } else {
//   //   splashNavigate = SplashNavigate.login;
//   // }

//   switch (splashNavigate) {
//     case SplashNavigate.home:
//       Get.off(() => const DrawerPage());
//       break;
//     case SplashNavigate.login:
//       // Get.off(() => const AuthView());
//       break;
//     case SplashNavigate.language:
//       // Get.off(() => const SelectLanguageView());
//       break;
//   }
//   return splashNavigate;
// });

// // final newUpdateProvider = FutureProvider.autoDispose<bool>((ref) async {
// //   final shorebirdCodePush = ShorebirdCodePush();
// //   final isUpdateAvailable =
// //       await shorebirdCodePush.isNewPatchAvailableForDownload();
// //   if (isUpdateAvailable) {
// //     ref.read(isUpdateAvailableProvider.notifier).state = true;
// //     await shorebirdCodePush.downloadUpdateIfAvailable();
// //   }
// //   return isUpdateAvailable;
// // });

// final isUpdateAvailableProvider = StateProvider.autoDispose<bool>((ref) {
//   return false;
// });

// final splashProvider = FutureProvider.autoDispose<bool>((ref) async {
//   final hasGetUser = await ref.read(fetchUserProvider.future);
//   final canNavigate = hasGetUser != null;
//   // final isUpdateAvailable = await ref.read(newUpdateProvider.future);
//   if (canNavigate) {
//     // if (!isUpdateAvailable) await Future.delayed(const Duration(seconds: 1));
//     ref.read(splashNavigateProvider);
//   }
//   return true;
// });

// final hasInternetProvider2 = StateProvider<bool>((ref) => true);

// final fuckInternetOk = Provider<bool>((ref) {
//   final a1 = ref.watch(hasInternetProvider);
//   final a2 = ref.watch(hasInternetProvider2);
//   if (a1.isLoading) {
//     return true;
//   } else if (a1.hasValue) {
//     if (a1.value!) {
//       return a2;
//     } else {
//       return false;
//     }
//   } else {
//     return a2;
//   }
// });

// final hasInternetProvider = StreamProvider<bool>((ref) {
//   ref.listenSelf((previous, next) {
//     if (previous?.value == false && next.value == true) {
//       ref.invalidate(hasInternetProvider2);
//     }
//   });
//   final stream = Connectivity().onConnectivityChanged;
//   return stream.map((event) => event != ConnectivityResult.none).distinct();
// });

// final userProvider = StateProvider<User?>((ref) {
//   ref.listenSelf((previous, next) {
//     if ((previous?.id != next?.id) || (next == null)) {}
//   });
//   return null;
// });
// final fetchUserProvider = FutureProvider.autoDispose<bool?>((ref) async {
//   await Future.delayed(const Duration(seconds: 3));
//   return true;

//   final token = dataManager.getToken();
//   final pastUserId = ref.read(userProvider)?.id;
//   if (token != null) {
//     final User? user =
//         await Future.delayed(Duration.zero).then((value) => null);
//     if (user != null) {
//       ref.read(userProvider.notifier).state = user;
//       if (pastUserId != user.id) {}
//       return true;
//     } else {
//       ref.read(userProvider.notifier).state = null;
//       return null;
//     }
//   } else {
//     return false;
//   }
// });
