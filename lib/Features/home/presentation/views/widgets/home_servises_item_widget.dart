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
      height: 160.h,
      margin: const EdgeInsetsDirectional.only(start: 12, end: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: color,
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => AllCategories(category.catNameAr, id: category.catId));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            ImageOrSvg(height: 90.h, imageUrl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(.7),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.white)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        category.catNameAr,
                        style: AppFontStyle.black_18.copyWith(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        category.catNameEn,
                        style: AppFontStyle.black_18.copyWith(
                            fontWeight: FontWeight.bold, color: textColor),
                      ),
                    ],
                  ),
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
      height: 160.h,
      margin: const EdgeInsetsDirectional.only(start: 12, end: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.primaryColor3,
      ),
      child: Shimmer.fromColors(
        baseColor: AppColors.primaryColor4.withOpacity(.3),
        highlightColor: AppColors.primaryColor4.withOpacity(.9),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 90.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: double.infinity,
                  height: 46.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
