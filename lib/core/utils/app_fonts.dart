import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppFontStyle {
  static TextStyle customTextStyle({
    double fontSize = 10,
    Color color = Colors.black,
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.tajawal(
      textStyle: TextStyle(
        fontSize: fontSize,
        color: color,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
    );
  }

  static TextStyle get black_12 => customTextStyle(
        fontSize: 12.sp,
      );

  static TextStyle get black_14 => customTextStyle(
        fontSize: 14.sp,
      );

  static TextStyle get black_16 => customTextStyle(
        fontSize: 16.sp,
      );

  static TextStyle get black_18 => customTextStyle(
        fontSize: 18.sp,
      );

  static TextStyle get black_22 => customTextStyle(
        fontSize: 22.sp,
      );

  static TextStyle get black_24 => customTextStyle(
        fontSize: 24.sp,
      );

  static TextStyle get black_28 => customTextStyle(
        fontSize: 28.sp,
      );

  static TextStyle get white_12 => customTextStyle(
        fontSize: 12.sp,
        color: Colors.white,
      );

  static TextStyle get white_14 => customTextStyle(
        fontSize: 14.sp,
        color: Colors.white,
      );

  static TextStyle get white_16 => customTextStyle(
        fontSize: 16.sp,
        color: Colors.white,
      );

  static TextStyle get white_18 => customTextStyle(
        fontSize: 18.sp,
        color: Colors.white,
      );

  static TextStyle get white_22 => customTextStyle(
        fontSize: 22.sp,
        color: Colors.white,
      );

  static TextStyle get white_24 => customTextStyle(
        fontSize: 24.sp,
        color: Colors.white,
      );

  static TextStyle get white_28 => customTextStyle(
        fontSize: 28.sp,
        color: Colors.white,
      );

  static TextStyle get grey_12 => customTextStyle(
        fontSize: 12.sp,
        color: Colors.grey,
      );

  static TextStyle get grey_14 => customTextStyle(
        fontSize: 14.sp,
        color: Colors.grey,
      );

  static TextStyle get grey_16 => customTextStyle(
        fontSize: 16.sp,
        color: Colors.grey,
      );

  static TextStyle get grey_18 => customTextStyle(
        fontSize: 18.sp,
        color: Colors.grey,
      );

  static TextStyle get grey_22 => customTextStyle(
        fontSize: 22.sp,
        color: Colors.grey,
      );

  static TextStyle get grey_24 => customTextStyle(
        fontSize: 24.sp,
        color: Colors.grey,
      );

  static TextStyle get grey_28 => customTextStyle(
        fontSize: 28.sp,
        color: Colors.grey,
      );

  // Additional styles
  static TextStyle get emphasized => customTextStyle(
        fontSize: 14.sp,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get italic => customTextStyle(
        fontSize: 14.sp,
        color: Colors.black,
        fontStyle: FontStyle.italic,
      );
}
