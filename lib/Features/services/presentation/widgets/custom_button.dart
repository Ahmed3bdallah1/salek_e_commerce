import 'package:car_rentting/core/utils/app_fonts.dart';

import '../../../../Ui/shared_widget/image_or_svg.dart';
import '../../../../core/functions/responsive.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.iconFirst = false,
    required this.color,
    this.onPressed,
    this.icon,
    this.height = 47,
    this.width = 167,
    this.fontSize,
    this.loading,
  });

  final String text;
  final Color color;
  final Widget? icon;
  final bool iconFirst;
  final double? fontSize;
  final double height;
  final double width;
  final void Function()? onPressed;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return InkWell(
      onTap: loading == true ? null : onPressed,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: loading == true ? null : color,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: loading == true
            ? const Center(
                child: LoadingWidget(),
              )
            : icon == null
                ? Center(
                    child: Text(
                    text,
                    style: AppFontStyle.white_22.copyWith(fontSize: 20.sp),
                  ))
                : iconFirst
                    ? Row(
                        children: [
                          Expanded(child: icon!),
                          Text(
                            text,
                            style:
                                AppFontStyle.white_22.copyWith(fontSize: 20.sp),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text,
                            style:
                                AppFontStyle.white_22.copyWith(fontSize: 20.sp),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          icon!
                        ],
                      ),
      ),
    );
  }
}
