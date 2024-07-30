import 'package:car_rentting/Ui/shared_widget/image_or_svg.dart';
import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/colors.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton(
      {super.key,
      required this.text,
      this.isLoading = false,
      this.color,
      this.height,
      this.onPressed,
      this.textSize,
      this.width,
      this.ignorePressOnNotValid = false,
      this.isValid = true,
      this.textColor});

  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final String text;
  final void Function()? onPressed;
  final bool isValid;
  final double? height;
  final double? width;
  final double? textSize;
  final bool ignorePressOnNotValid;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return FilledButton(
      style: ButtonStyle(
          fixedSize:
              MaterialStateProperty.all(Size(width ?? 1.sw, height ?? 54.h)),
          backgroundColor: MaterialStateProperty.all(!isValid
              ? Theme.of(context).disabledColor
              : color ?? AppColors.primaryColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r)))),
      onPressed:
          isLoading || (ignorePressOnNotValid && !isValid) ? null : onPressed,
      child: isLoading
          ? const LoadingWidget(
              color: Colors.white,
            )
          : Text(
              text,
              style: TextStyle(
                  color: textColor ?? Theme.of(context).colorScheme.secondary,
                  fontSize: textSize ?? 20.sp,
                  fontWeight: FontWeight.w600),
            ),
    );
  }
}
