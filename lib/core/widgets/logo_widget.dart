import 'package:car_rentting/core/functions/responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../gen/assets.gen.dart';

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
      Assets.socialMedia.logo.path,
      width: 0.64.sw,
    );
  }
}
