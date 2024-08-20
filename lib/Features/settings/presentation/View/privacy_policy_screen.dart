import 'package:car_rentting/Features/settings/presentation/manager/fetch_policy_provider.dart';
import 'package:car_rentting/Ui/shared_widget/custom_button.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../../../core/utils/colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor4,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: AppColors.primaryColor3,
        title: Text('Privacy Policy'.tr),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final terms = ref.watch(fetchPolicyProvider);
          return terms.customWhen(
            refreshable: fetchPolicyProvider.future,
            ref: ref,
            data: (termsData) {

              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: HtmlWidget(
                    termsData.termsAr ?? "",
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomSheet: Container(
        color: AppColors.primaryColor4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomFilledButton(
            text: "Ok".tr,
            textColor: Colors.white,
            color: AppColors.primaryColorSALEK2,
            onPressed: () => Get.back(),
          ),
        ),
      ),
    );
  }
}
