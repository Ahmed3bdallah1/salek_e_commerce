// import 'package:car_rentting/core/functions/responsive.dart';
// import 'package:car_rentting/core/utils/app_fonts.dart';
// import 'package:car_rentting/core/utils/colors.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar({
//     super.key,
//     required this.title,
//     required this.isRoot,
//   });
//
//   final String title;
//   final bool isRoot;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: isRoot
//           ? IconButton(
//               icon: const Icon(
//                 Icons.menu,
//                 color: AppColors.lightColor,
//               ),
//               onPressed: () {
//                 ZoomDrawer.of(context)!.toggle();
//               },
//             )
//           : null,
//       backgroundColor: Colors.transparent,
//       title: Text(title,
//           style: AppFontStyle.black_28.copyWith(fontWeight: FontWeight.bold)),
//       actions: const [],
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(70);
// }
