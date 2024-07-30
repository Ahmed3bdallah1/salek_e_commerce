import 'package:car_rentting/core/functions/responsive.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    this.colorText,
    this.colorImage,
    super.key,
  });

  final Color? colorText;
  final Color? colorImage;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return Image.asset(
      "assets/base/logo.png",
      color: colorImage ?? Colors.white,
      width: 0.64.sw,
    );
  }
}
