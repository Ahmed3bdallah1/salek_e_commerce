import 'package:car_rentting/Features/auth/data/models/login_request_model.dart';
import 'package:car_rentting/Features/auth/data/models/register_request_model.dart';
import 'package:car_rentting/Features/auth/domain/repositories/auth_repo.dart';
import 'package:car_rentting/Features/auth/domain/use_cases/user_login_use_case.dart';
import 'package:car_rentting/Features/auth/domain/use_cases/user_register_use_case.dart';
import 'package:car_rentting/Features/auth/presentation/manager/current_user_provider.dart';
import 'package:car_rentting/Features/home/presentation/views/root_view.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:car_rentting/core/utils/local_data_manager.dart';
import 'package:car_rentting/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );
    return Stack(
      children: [
        FlutterLogin(
          loginProviders: [
            LoginProvider(
              icon: (Icons.person),
              callback: () async {
                return Get.offAll(() => const RootView());
              },
              label: "Login as Guest".tr,
            ),
          ],
          hideForgotPasswordButton: true,
          messages: LoginMessages(
            signupButton: "Register".tr,
            loginButton: "Login".tr,
            goBackButton: "Back".tr,
            forgotPasswordButton: "Forgot Password".tr,
            passwordHint: "Enter Your Password".tr,
            userHint: "Enter Your Email".tr,
            confirmPasswordHint: "Enter Your Password Again".tr,
            additionalSignUpFormDescription: "Complete Your Profile".tr,
            additionalSignUpSubmitButton: "Register".tr,
          ),
          logo: 'assets/base/logo3.png',
          onLogin: (loginData) async {
            final das = await UserLoginUseCase(getIt<AuthRepo>()).call(
                LoginRequestModel(
                    fcmToken: (await FirebaseMessaging.instance.getToken())
                        .toString(),
                    email: loginData.name,
                    password: loginData.password));
            return das.fold((l) {
              return l.message;
            }, (r) {
              ref.read(currentUserProvider.notifier).state = r;
              return Get.offAll(() => const RootView());
            });
          },
          onSignup: (loginData) async {
            final das = await UserRegisterUseCase(getIt<AuthRepo>())
                .call(RegisterRequestModel(
              fcmToken: await FirebaseMessaging.instance.getToken(),
              name: loginData.additionalSignupData!['userName']!,
              phone: loginData.additionalSignupData!['phone']!,
              company: loginData.additionalSignupData!['company']!,
              address: loginData.additionalSignupData!['address']!,
              email: loginData.name!,
              password: loginData.password!,
            ));
            return das.fold((l) {
              return l.message;
            }, (r) {
              ref.read(currentUserProvider.notifier).state = r;
              return Get.offAll(() => const RootView());
            });
          },
          onRecoverPassword: (_) {
            return null;
          },
          theme: LoginTheme(
            switchAuthTextColor: Colors.black,
            buttonTheme: const LoginButtonTheme(
              backgroundColor: Colors.black,
            ),
            textFieldStyle: GoogleFonts.tajawal(),
            buttonStyle: GoogleFonts.tajawal(
              color: Colors.white,
            ),
            inputTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: inputBorder,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: inputBorder,
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
            ),
            titleStyle: GoogleFonts.tajawal(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            primaryColor: AppColors.lightColor2,
            pageColorLight: AppColors.primaryColorSALEK2,
          ),
          additionalSignupFields: [
            UserFormField(
              keyName: 'userName',
              displayName: "Name".tr,
              userType: LoginUserType.name,
              fieldValidator: (value) {
                if (value?.trimLeft().trimRight().isEmpty == true) {
                  return 'Name is required'.tr;
                }
                return null;
              },
            ),
            UserFormField(
              keyName: 'phone',
              displayName: "Phone".tr,
              userType: LoginUserType.phone,
              icon: const Icon(Icons.call),
              fieldValidator: (value) {
                if (value?.trimLeft().trimRight().isEmpty == true) {
                  return 'Phone is required'.tr;
                }
                return null;
              },
            ),
            UserFormField(
              keyName: 'company',
              displayName: "Company".tr,
              userType: LoginUserType.text,
              icon: const Icon(Icons.location_city),
              fieldValidator: (value) {
                if (value?.trimLeft().trimRight().isEmpty == true) {
                  return 'Company name is required'.tr;
                }
                return null;
              },
            ),
            UserFormField(
              keyName: 'address',
              displayName: "Address".tr,
              userType: LoginUserType.text,
              icon: Icon(Icons.location_on),
              fieldValidator: (value) {
                if (value?.trimLeft().trimRight().isEmpty == true) {
                  return 'Address is required'.tr;
                } else if (value!.length < 10) {
                  return 'Address is must be 10 characters or more'.tr;
                }
                return null;
              },
            ),
          ],

          title: "سالك",

          // logo: 'assets/images/logo.png',
        ),

        //login as guest
      ],
    );
  }
}
