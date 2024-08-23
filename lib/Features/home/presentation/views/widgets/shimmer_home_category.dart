import 'package:car_rentting/Features/home/presentation/views/widgets/home_servises_item_widget.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategoryShimmer extends StatelessWidget {
  const HomeCategoryShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "How Can We Help You".tr + "?".tr,
            style: AppFontStyle.black_18.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 4,
          itemBuilder: (c, i) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: HomeServicesItemShimmer(),
            );
          },
        ),
      ],
    );
  }
}
