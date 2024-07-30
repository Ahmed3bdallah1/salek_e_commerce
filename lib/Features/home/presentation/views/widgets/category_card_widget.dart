import 'package:car_rentting/Features/categories/presentation/view/all_categories.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/app_fonts.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:car_rentting/core/utils/const.dart';
import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';

import '../../../../services/domain/entities/service_entity.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
  });

  final ServiceEntity category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => AllCategories(id: category.catId));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          width: 109.w,
          height: 140.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.grayC4,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: ExtendedNetworkImageProvider(
                uploadPath + category.catImage,
                cache: true,
              ),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff525252).withOpacity(0.6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 6,
                    blurRadius: 9,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 30.h,
              child: Center(
                child: Text(category.catNameAr,
                    maxLines: 2, style: AppFontStyle.white_14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
