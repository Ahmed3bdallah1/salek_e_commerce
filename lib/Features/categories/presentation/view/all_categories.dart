import 'dart:math';

import 'package:car_rentting/Features/categories/presentation/view/widgets/category_item_widget.dart';
import 'package:car_rentting/Ui/shared_widget/custom_error_widget.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/functions/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../domain/use_cases/category_services_use_cases.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key, this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final provider =
          id == null ? fetchCategoriesProvider : fetchServicesProvider(id!);

      return Scaffold(
        body: ref.watch(provider).customWhen(
              ref: ref,
              refreshable: provider.future,
              data: (data) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Categories".tr),
                  ),
                  body: Builder(
                    builder: (context) {
                      if (data.isEmpty) {
                        return EmptyWidget(
                          onRetry: () {
                            return ref.refresh(provider.future);
                          },
                        );
                      }
                      final isPrimary = id == null;
                      return GridView.builder(
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
                                childAspectRatio: isPrimary ? 1.1843971631 : 1,
                              )
                            : SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 11,
                                mainAxisSpacing: 11,
                                childAspectRatio: isPrimary ? 1.1843971631 : 2,
                              ),
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryItem(
                            data[index],
                            isPrimary: isPrimary,
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
      );
    });
  }
}
