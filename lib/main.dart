import 'package:car_rentting/Features/auth/data/data_sources/auth_date_source.dart';
import 'package:car_rentting/Features/auth/domain/use_cases/fetch_user_data_use_case.dart';
import 'package:car_rentting/Features/auth/domain/use_cases/update_password_use_case.dart';
import 'package:car_rentting/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:car_rentting/Features/home/data/data_sources/services_remote_data_source.dart';
import 'package:car_rentting/Features/home/data/repos/home_repo_impl.dart';
import 'package:car_rentting/Features/home/data/repos/service_repo_impl.dart';
import 'package:car_rentting/Features/home/domain/repos/home_repo.dart';
import 'package:car_rentting/Features/home/domain/repos/services_repo.dart';
import 'package:car_rentting/Features/orders/data/data_sources/orders_data_source.dart';
import 'package:car_rentting/Features/orders/data/repositories/orders_repo_impl.dart';
import 'package:car_rentting/Features/orders/domain/repositories/order_repo.dart';
import 'package:car_rentting/Features/services/domain/repositories/service_repo.dart';
import 'package:car_rentting/Features/setting/data/data_source/settings_data_source.dart';
import 'package:car_rentting/Features/setting/data/repositories/settings_repo_imp.dart';
import 'package:car_rentting/Features/setting/domain/repositories/settings_repo.dart';
import 'package:car_rentting/Features/settings/data/data_source/policy_data_source.dart';
import 'package:car_rentting/Features/settings/data/repo/policy_repo_imp.dart';
import 'package:car_rentting/Features/settings/domain/repo/policy_repo.dart';
import 'package:car_rentting/Features/settings/domain/use_case/fetch_policy_use_case.dart';
import 'package:car_rentting/Features/splash/views/splash_view.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/api_service.dart';
import 'package:car_rentting/core/utils/app_fonts.dart';
import 'package:car_rentting/core/utils/app_translation.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Features/auth/data/repositories/auth_repo_impl.dart';
import 'Features/auth/domain/repositories/auth_repo.dart';
import 'Features/services/data/data_sources/service_data_source.dart';
import 'Features/services/data/repositories/service_repo_impl.dart';
import 'Features/setting/domain/use_cases/fetch_settings.dart';
import 'core/utils/local_data_manager.dart';
import 'firebase_options.dart';

final getIt = GetIt.instance;

Future setupLocator() async {
  await GetStorage.init();
  getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  getIt.registerLazySingleton<LocalDataManager>(() => LocalDataManagerImpl());
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  getIt.registerLazySingleton<HomeDataSource>(
      () => HomeDataSourceImpl(getIt<ApiService>()));
  getIt.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(dataSource: getIt<HomeDataSource>()));
  getIt.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(apiService: getIt<ApiService>()));
  getIt.registerLazySingleton<SettingsDataSource>(
      () => SettingsDataSourceImpl(apiService: getIt<ApiService>()));
  getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(getIt<AuthDataSource>(), getIt<LocalDataManager>()));
  getIt.registerLazySingleton<SettingsRepo>(
      () => SettingsRepoImp(settingsDataSource: getIt<SettingsDataSource>()));
  getIt.registerLazySingleton<FetchUserDataUseCase>(
      () => FetchUserDataUseCase(authRepo: getIt<AuthRepo>()));
  getIt.registerLazySingleton<FetchSettingsUseCase>(
      () => FetchSettingsUseCase(settingsRepo: getIt<SettingsRepo>()));
  getIt.registerLazySingleton<UpdatePasswordUseCase>(
      () => UpdatePasswordUseCase(authRepo: getIt<AuthRepo>()));
  getIt.registerLazySingleton<ServicesDataSource>(
      () => ServicesDataSourceImpl(getIt<ApiService>()));
  getIt.registerLazySingleton<ServicesRepo>(
      () => ServicesRepoImpl(dataSource: getIt<ServicesDataSource>()));

  getIt.registerLazySingleton<PrivacyPolicyDataSource>(
      () => PrivacyPolicyDataSourceImpl(apiService: getIt<ApiService>()));
  getIt.registerLazySingleton<PrivacyPolicyRepo>(() => PrivacyPolicyRepoImp(
      privacyPolicyDataSource: getIt<PrivacyPolicyDataSource>()));
  getIt.registerLazySingleton<FetchPolicyUseCase>(
      () => FetchPolicyUseCase(policyRepo: getIt<PrivacyPolicyRepo>()));

  getIt.registerLazySingleton<ServiceDataSource>(
      () => ServiceDataSourceImpl(apiService: getIt<ApiService>()));
  getIt.registerLazySingleton<ServiceRepo>(
      () => ServiceRepoImpl(getIt<ServiceDataSource>()));
  getIt.registerLazySingleton<OrdersDataSource>(
      () => OrdersDataSourceImpl(getIt<ApiService>()));
  getIt.registerLazySingleton<OrderRepo>(
      () => OrderRepoImpl(orderDataSource: getIt<OrdersDataSource>()));
}

final ProviderContainer providerContainer = ProviderContainer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupNotification();

  runApp(UncontrolledProviderScope(
      container: providerContainer, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return ScreenUtilInit(
        fontSizeResolver: FontSizeResolvers.height,
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(375, 812),
        builder: (context, child) {
          return GetMaterialApp(
            theme: FlexThemeData.light(
              appBarStyle: FlexAppBarStyle.background,
              scheme: FlexScheme.greyLaw,
               fontFamily: GoogleFonts.tajawal().fontFamily,
            ),
            themeMode: ThemeMode.light,
            title: 'سالك',
            debugShowCheckedModeBanner: false,
            home: const SplashView(),
            translations: Translation(),
            locale: const Locale("ar"),
          );
        });
  }
}

Future setupNotification() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // await getIt<LocalDataManager>()
    //     .setFCMToken(await FirebaseMessaging.instance.getToken());
  } finally {
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      UIHelper.showGlobalSnackBar(
        text: event.notification?.body,
        title: event.notification?.title,
        onTap: (j) {},
      );
    });
  }
}

class UIHelper {
  static Future<bool?> showSelectableDialog(
    String msg,
    String cancel,
    String ok, {
    BuildContext? context,
    bool invertColors = false,
    AlertType type = AlertType.none,
  }) {
    return Alert(
      type: type,
      context: context ?? Get.context!,
      title: msg,
      style: AlertStyle(titleStyle: AppFontStyle.black_12),
      buttons: [
        DialogButton(
          color: invertColors ? Colors.green : Colors.red,
          child: FittedBox(
            child: Text(
              cancel,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          onPressed: () => Get.back(result: false),
        ),
        DialogButton(
          color: invertColors ? Colors.red : Colors.green,
          child: FittedBox(
            child: Text(
              ok,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          onPressed: () => Get.back(result: true),
        ),
      ],
    ).show();
  }

  static SnackbarController showGlobalSnackBar({
    String? title,
    String? text,
    Color color = Colors.grey,
    void Function(GetSnackBar)? onTap,
  }) {
    return Get.showSnackbar(
      GetSnackBar(
        messageText: text != null
            ? Text(
                text,
                style: const TextStyle(),
              )
            : null,
        titleText: title != null
            ? Text(
                title,
                style: const TextStyle(),
              )
            : null,
        snackPosition: SnackPosition.TOP,
        borderRadius: 15,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        duration: const Duration(seconds: 3),
        barBlur: 7.0,
        backgroundColor: color.withOpacity(0.7),
        dismissDirection: DismissDirection.vertical,
        onTap: onTap,
      ),
    );
  }
}
