import 'package:car_rentting/Features/home/presentation/manager/root_index_provider.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/app_fonts.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationItem extends ConsumerWidget {
  const BottomNavigationItem({
    super.key,
    required this.index,
    required this.title,
    required this.icon,
  });

  final int index;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context, ref) {
    final isSelected = ref.watch(rootIndexProvider) == index;
    return InkWell(
      onTap: () {
        ref.read(rootIndexProvider.notifier).state = index;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24.r,
            color: isSelected
                ? AppColors.lightColor2
                : Colors.black.withOpacity(.8),
          ),
          SizedBox(
            width: 4.w,
          ),
          Text(title,
              maxLines: 1,
              style: AppFontStyle.black_14.copyWith(
                color: isSelected
                    ? AppColors.lightColor2
                    : Colors.black.withOpacity(.8),
              )),
        ],
      ),
    );
  }
}
