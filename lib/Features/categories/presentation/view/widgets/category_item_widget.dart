import 'package:car_rentting/Features/categories/presentation/view/all_categories.dart';
import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/const.dart';
import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/app_fonts.dart';
import '../../../../services/presentation/views/servics_view.dart';

class CategoryItem extends StatelessWidget {
  final bool isPrimary;
  final ServiceEntity serviceEntity;
  final bool isProduct;

  const CategoryItem(this.serviceEntity, {super.key,


   required this.isPrimary,
   required this.isProduct


   });

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return InkWell(
      onTap: () {
        if (isPrimary) {
          Get.to(() => AllCategories(
            '${serviceEntity.catNameAr}',
                id: serviceEntity.catId,

              ));
        } else {
          Get.to(() => ServiceScreen(
                serviceEntity.catId,
                isProduct: isProduct,
              ));
        }
      },
      child: Container(
        width: 178.w,
        height: 220.h,
        decoration: ShapeDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: ExtendedNetworkImageProvider(
              uploadPath + serviceEntity.catImage,
              cache: true,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: -6,
                blurRadius: 9,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: const Color(0xff525252).withOpacity(0.6),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(serviceEntity.catNameAr,
                      maxLines: 1, style: AppFontStyle.white_16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(serviceEntity.catDescriptionAr,
                          maxLines: 1,
                          style:
                              AppFontStyle.white_12.copyWith(fontSize: 10.sp)),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 8.0),
                child: PriceWidget(serviceEntity),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
