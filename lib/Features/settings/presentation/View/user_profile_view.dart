// ignore_for_file: prefer_const_constructors

import 'package:car_rentting/Features/auth/domain/use_cases/update_password_use_case.dart';
import 'package:car_rentting/Features/services/presentation/views/servics_view.dart';
import 'package:car_rentting/Ui/shared_widget/custom_button.dart';
import 'package:car_rentting/Ui/shared_widget/custom_text_field.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:car_rentting/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/functions/validators.dart';

final showPasswordProvider =
    StateProvider.family.autoDispose<bool, dynamic>((ref, _) {
  return true;
});

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a FormGroup for your form

    final form = FormGroup({
      'password': FormControl<String>(validators: [Validators.required]),
      'password_confirmation':
          FormControl<String>(validators: [Validators.required]),
      'old_password': FormControl<String>(validators: [Validators.required]),
    }, validators: [
      Validators.mustMatch("password", "password_confirmation"),
      MustNotMatchValidator("old_password", 'password', true),
    ]);

    return Scaffold(
      backgroundColor: AppColors.primaryColor4,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: AppColors.primaryColor3,
        title: Text('Change Password'.tr),
      ),
      body: SingleChildScrollView(
        child: ReactiveForm(
          formGroup: form, // Provide the form group to ReactiveForm
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                Consumer(builder: (context, ref, child) {
                  final showPassword =
                      ref.watch(showPasswordProvider("old_password"));
                  return CustomTextField(
                    obscure: showPassword,
                    formControlName: 'old_password',
                    labelText: 'Old Password'.tr,
                    hintText: "Enter your old password".tr,
                    iconButton: IconButton(
                      onPressed: () {
                        ref
                            .read(showPasswordProvider("old_password").notifier)
                            .state = !showPassword;
                      },
                      icon: Icon(showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  );
                }),
                SizedBox(height: 10),
                Consumer(builder: (context, ref, child) {
                  final showPassword =
                      ref.watch(showPasswordProvider("password"));
                  return CustomTextField(
                    obscure: showPassword,
                    formControlName: 'password',
                    labelText: 'New Password'.tr,
                    hintText: "Enter your new password".tr,
                    iconButton: IconButton(
                      onPressed: () {
                        ref
                            .read(showPasswordProvider("password").notifier)
                            .state = !showPassword;
                      },
                      icon: Icon(showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  );
                }),
                SizedBox(height: 10),
                Consumer(builder: (context, ref, child) {
                  final showPassword =
                      ref.watch(showPasswordProvider("password_confirmation"));
                  return CustomTextField(
                    obscure: showPassword,
                    formControlName: 'password_confirmation',
                    labelText: 'Confirm New Password'.tr,
                    hintText: "Enter Your New Password Again".tr,
                    iconButton: IconButton(
                      onPressed: () {
                        ref
                            .read(showPasswordProvider("password_confirmation")
                                .notifier)
                            .state = !showPassword;
                      },
                      icon: Icon(showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  );
                }),
                SizedBox(height: 20),
                Consumer(builder: (context, ref, child) {
                  final isLoading =
                      ref.watch(isLoadingProvider("edit_password"));
                  return ReactiveFormConsumer(builder: (context, form, child) {
                    return CustomFilledButton(
                      isValid: form.valid,
                      text: 'Edit'.tr,
                      textColor: Colors.white,
                      color: AppColors.primaryColor1,
                      isLoading: isLoading,
                      onPressed: () async {
                        if (form.valid) {
                          ref
                              .read(isLoadingProvider("edit_password").notifier)
                              .state = true;
                          final res = await getIt<UpdatePasswordUseCase>()(
                              (form.value));

                          res.fold((l) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(l.message.toString()),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ));
                          }, (r) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('password changed successfully'.tr),
                              backgroundColor: Colors.green,
                            ));
                            Navigator.pop(context);
                          });
                          ref
                              .read(isLoadingProvider("edit_password").notifier)
                              .state = false;
                        } else {
                          form.markAllAsTouched();
                        }
                      },
                    );
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
