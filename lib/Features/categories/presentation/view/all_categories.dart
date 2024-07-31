import 'dart:math';

import 'package:car_rentting/Features/categories/presentation/view/widgets/category_item_widget.dart';
import 'package:car_rentting/Ui/shared_widget/custom_error_widget.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:car_rentting/core/utils/app_fonts.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../domain/use_cases/category_services_use_cases.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key, this.id});

  final int? id;

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final provider = widget.id == null
          ? fetchCategoriesProvider
          : fetchServicesProvider(widget.id!);

      return Scaffold(
        appBar: AppBar(
          title: Text("Categories".tr),
        ),
        body: ref.watch(provider).customWhen(
              ref: ref,
              refreshable: provider.future,
              data: (data) {
                if (data.isEmpty) {
                  return EmptyWidget(
                    onRetry: () {
                      return ref.refresh(provider.future);
                    },
                  );
                }
                final isPrimary = widget.id == null;
                return Column(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        // indicator: BoxDecoration(
                        //   color: AppColors.primaryColorSALEK1,
                        //   borderRadius: BorderRadius.circular(12),
                        // ),
                        controller: controller,
                        dividerColor: AppColors.primaryColorSALEK1,
                        isScrollable: false,
                        tabs: [
                          Tab(
                            child: SizedBox(
                              child: Center(
                                child: Text(
                                  'Products'.tr,
                                  style: AppFontStyle.black_18,
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: SizedBox(
                              child: Center(
                                child: Text(
                                  'Services'.tr,
                                  style: AppFontStyle.black_18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: controller,
                        children: [
                          GridView.builder(
                            itemCount: data.length,
                            padding: EdgeInsets.all(11.w),
                            gridDelegate: isPrimary
                                ? SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        context.mediaQuerySize.shortestSide <
                                                300
                                            ? 1
                                            : max(context.width ~/ 385 + 1, 2),
                                    crossAxisSpacing: 11,
                                    mainAxisSpacing: 11,
                                    childAspectRatio:
                                        isPrimary ? 1.1843971631 : 1,
                                  )
                                : SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 11,
                                    mainAxisSpacing: 11,
                                    childAspectRatio:
                                        isPrimary ? 1.1843971631 : 2,
                                  ),
                            itemBuilder: (BuildContext context, int index) {
                              return CategoryItem(
                                data[index],
                                isPrimary: isPrimary,
                              );
                            },
                          ),
                          GridView.builder(
                            itemCount: data.length,
                            padding: EdgeInsets.all(11.w),
                            gridDelegate: isPrimary
                                ? SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        context.mediaQuerySize.shortestSide <
                                                300
                                            ? 1
                                            : max(context.width ~/ 385 + 1, 2),
                                    crossAxisSpacing: 11,
                                    mainAxisSpacing: 11,
                                    childAspectRatio:
                                        isPrimary ? 1.1843971631 : 1,
                                  )
                                : SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 11,
                                    mainAxisSpacing: 11,
                                    childAspectRatio:
                                        isPrimary ? 1.1843971631 : 2,
                                  ),
                            itemBuilder: (BuildContext context, int index) {
                              return CategoryItem(
                                data[index],
                                isPrimary: isPrimary,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
      );
    });
  }
}
