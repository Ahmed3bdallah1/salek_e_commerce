// ignore_for_file: prefer_const_constructors

import 'package:car_rentting/Features/auth/presentation/manager/current_user_provider.dart';
import 'package:car_rentting/Features/categories/domain/use_cases/category_services_use_cases.dart';
import 'package:car_rentting/Features/chat/presentation/chat_screen.dart';
import 'package:car_rentting/Features/home/presentation/views/widgets/home_servises_item_widget.dart';
import 'package:car_rentting/Features/home/presentation/views/widgets/shimmer_home_category.dart';
import 'package:car_rentting/Features/home/presentation/views/widgets/silder_home_widget.dart';
import 'package:car_rentting/Features/setting/presentation/widgets/whatsapp_floating_action.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:car_rentting/core/utils/app_fonts.dart';
import 'package:car_rentting/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../auth/presentation/manager/get_user_provider.dart';
import '../../../setting/presentation/managers/fetch_settings_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer(
        builder: (context, ref, widget) {
          final settings = ref.watch(fetchSettingsProvider);
          return settings.customWhen(
              ref: ref,
              refreshable: fetchSettingsProvider.future,
              loading: () => SizedBox(),
              data: (data) {
                final phone = data.firstWhereOrNull(
                    (element) => element.nameEn == "Phone Number");

                if (phone == null) {
                  return SizedBox();
                } else {
                  void launchInWhats(String phone) {
                    String? encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }

                    launchUrlString(
                      """https://wa.me/2$phone?${encodeQueryParameters({
                            'text': ''
                          })}""",
                      mode: LaunchMode.externalApplication,
                    );
                  }

                  return WhatsappFloatingIcon(
                    onPressed: () {
                      launchInWhats("${phone.valueEn}");
                    },
                  );
                }
              });
        },
      ),
      appBar: AppBar(
        title: Consumer(builder: (context, ref, child) {
          final userName = ref.watch(currentUserProvider)?.name;
          return Text("${"Welcome".tr} ${userName ?? ''} 👋");
        }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Consumer(builder: (context, ref, child) {
                final fetchData = ref.watch(fetchCategoriesProvider);
                return fetchData.customWhen(
                    ref: ref,
                    refreshable: fetchCategoriesProvider.future,
                    loading: () {
                      return HomeCategoryShimmer();
                    },
                    data: (categories) {
                      if (categories.isEmpty) {
                        return const SizedBox();
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "How Can We Help You".tr + "?".tr,
                                style: AppFontStyle.black_18
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: categories.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.1,
                                      mainAxisExtent: 180.h),
                              itemBuilder: (c, i) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: HomeServicesItem(
                                    textColor: categories[i].catTextColor,
                                    category: categories[i],
                                    color: categories[i].catColor,
                                    imageUrl: categories[i].catImage,
                                    title: categories[i].catNameAr,
                                  ),
                                );
                              },
                              // separatorBuilder:
                              //     (BuildContext context, int index) {
                              //   return SizedBox(
                              //     width: 17,
                              //   );
                              // },
                            ),
                          ],
                        );
                      }
                    });
              }),
              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
                child: HomeSliderWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
