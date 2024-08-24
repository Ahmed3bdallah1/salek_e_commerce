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

final selectedTypeCategoryProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

class AllCategories extends ConsumerStatefulWidget {
  const AllCategories(this.name,{super.key, this.id});
  final String? name;

  final int? id;

  @override
  ConsumerState<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends ConsumerState<AllCategories>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this)..addListener(() {
        ref.read(selectedTypeCategoryProvider.notifier).state = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
       final provider = widget.id == null
          ? fetchCategoriesProvider
          : fetchServicesProvider(widget.id!);
    return Scaffold(
      backgroundColor: AppColors.primaryColor5,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor3,
        title: Text(widget.name == null ? "Categories".tr : widget.name!),
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          controller: controller,
          dividerColor: AppColors.primaryColorSALEK1,
          isScrollable: false,
          tabs: [
            Tab(
              child: SizedBox(
                child: Center(
                  child: Text(
                    'Services'.tr,
                    style: AppFontStyle.black_18,
                  ),
                ),
              ),
            ),
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
          ],
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        return ref.watch(provider).customWhen(
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
              return TabBarView(
                controller: controller,
                children: [
                  GridView.builder(
                    itemCount: data.length,
                    padding: EdgeInsets.all(11.w),
                    gridDelegate: isPrimary
                        ? SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                context.mediaQuerySize.shortestSide < 300
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
                        isProduct: true,
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
                                context.mediaQuerySize.shortestSide < 300
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
                                                isProduct: false,

                        isPrimary: isPrimary,
                      );
                    },
                  ),
                ],
              );
            },
          );
      },));
  }
}
