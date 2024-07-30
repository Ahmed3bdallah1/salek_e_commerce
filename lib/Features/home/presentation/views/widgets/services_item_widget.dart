// import 'package:car_rentting/Features/categories/presentation/view/all_categories.dart';
// import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
// import 'package:car_rentting/Features/services/presentation/views/servics_view.dart';
// import 'package:car_rentting/core/functions/responsive.dart';
// import 'package:car_rentting/core/utils/app_fonts.dart';
// import 'package:car_rentting/core/utils/colors.dart';
// import 'package:car_rentting/core/utils/const.dart';
// import 'package:extended_image/extended_image.dart';
// import 'package:get/get.dart';

// class ServiceItem extends StatelessWidget {
//   const ServiceItem({
//     super.key,
//     required this.item,
//     required this.isPrimary,
//   });
//
//   final ServiceEntity item;
//   final bool isPrimary;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         if (isPrimary) {
//           Get.to(() => AllCategories(
//                 id: item.catId,
//               ));
//         } else {
//           Get.to(() => ServiceScreen(
//                 item.catId,
//               ));
//         }
//       },
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8.r),
//         child: Stack(
//           alignment: AlignmentDirectional.topEnd,
//           children: [
//             Container(
//               width: 244.w,
//               height: 165.h,
//               decoration: BoxDecoration(
//                 color: AppColors.grayC4,
//                 image: DecorationImage(
//                   fit: BoxFit.fill,
//                   image: ExtendedNetworkImageProvider(
//                     uploadPath + item.catImage,
//                     cache: true,
//                   ),
//                 ),
//               ),
//               child: Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Container(
//                   color: const Color(0xff525252).withOpacity(0.6),
//                   padding:
//                       EdgeInsetsDirectional.only(start: 15.w, bottom: 12.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(item.catNameAr,
//                               maxLines:2, style: AppFontStyle.white_16),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(item.catDescriptionAr,
//                                   maxLines: 2,
//                                   style: AppFontStyle.white_12
//                                       .copyWith(fontSize: 10.sp)),
//                             ],
//                           )
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsetsDirectional.only(end: 8.0),
//                         child: PriceWidget(item),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
