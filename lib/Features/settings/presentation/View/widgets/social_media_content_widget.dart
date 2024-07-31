import 'package:car_rentting/core/functions/responsive.dart';
import 'package:flutter/material.dart';

class SocialMediaContent extends StatelessWidget {
  final Function()? ontap;
  final String image;

  const SocialMediaContent(
      {super.key, required this.ontap, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: InkWell(
        onTap: ontap,
        child: Image.asset(
          image,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          // color: AppColors.primaryColorSALEK1,
        ),
      ),
    );
  }
}
