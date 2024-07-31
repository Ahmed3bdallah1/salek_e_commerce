import 'package:car_rentting/Features/categories/presentation/view/all_categories.dart';
import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:car_rentting/Ui/shared_widget/image_or_svg.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/app_fonts.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeServicesItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Color color;
  final Color textColor;
  final ServiceEntity category;

  const HomeServicesItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.color,
    required this.textColor,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      margin: const EdgeInsetsDirectional.only(start: 12, end: 12),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
      child: InkWell(
        onTap: () {
          Get.to(() => AllCategories(id: category.catId));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            ImageOrSvg(height: 80.h, width: 100.w, imageUrl),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(.7),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppFontStyle.black_18.copyWith(
                          fontWeight: FontWeight.bold, color: textColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeServicesItemShimmer extends StatelessWidget {
  const HomeServicesItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      margin: const EdgeInsetsDirectional.only(start: 12, end: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[300],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 80.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              width: 70.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
