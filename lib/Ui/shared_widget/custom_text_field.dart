 import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';


enum TextFieldType { text, selectable }

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.formControlName,
    this.autofillHints,
    this.inputType = TextInputType.text,
    this.style = 1,
    this.inputFormatter,
    this.paddingFromTop = false,
    this.onEditDone,
    this.onTap,
    this.obscure = false,
    this.maxLines = 1,
    this.control,
    this.iconDataPrefix,
    this.iconColor = Colors.grey,
    this.iconButton,
    this.type = TextFieldType.text,
    this.items,
    this.onChanged,
    this.borderRadius,
    this.hideSelectableIconIfIgnore = true,
    this.ignore = false,
    this.labelText,
    this.prefixText,
    this.suffixText,
  });

  final Iterable<String>? autofillHints;
  final String? formControlName;
  final FormControl? control;
  final String? hintText;
  final String? labelText;
  final int style;
  final Widget? iconButton;
  final bool obscure;
  final bool ignore;
  final int maxLines;
  final VoidCallback? onEditDone;
  final bool paddingFromTop;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType inputType;
  final void Function()? onTap;
  final TextFieldType type;
  final List<DropdownMenuItem>? items;
  final String? prefixText;
  final String? suffixText;
  final Widget? iconDataPrefix;
  final Color iconColor;
  final ReactiveFormFieldCallback? onChanged;
  final BorderRadius? borderRadius;
  final bool hideSelectableIconIfIgnore;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    final validation = {
      ValidationMessage.email: (controller) => ValidationMessage.email.tr,
      ValidationMessage.required: (controller) => ValidationMessage.required.tr,
      ValidationMessage.number: (controller) => ValidationMessage.number.tr,
      ValidationMessage.minLength: (controller) =>
          ValidationMessage.minLength.tr,
      ValidationMessage.maxLength: (controller) =>
          ValidationMessage.maxLength.tr,
      ValidationMessage.mustMatch: (controller) =>
          ValidationMessage.mustMatch.tr,
      "phone_number_must_start_with_01": (controller) =>
          "phone_number_must_start_with_01".tr,
    };
    final InputDecoration decoration = InputDecoration(
      contentPadding: EdgeInsetsDirectional.only(start: 8.w),
      labelStyle: AppFont.labelTextField,
      filled: false,
      suffixIcon: iconButton,
      prefixIcon: iconDataPrefix,
      hintText: hintText,
      prefixText: prefixText,
      suffixText: suffixText,
      prefixStyle: AppFont.textFiled,
      suffixStyle: AppFont.textFiled,
      hintStyle: AppFont.hintTextField,
      border: OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.grey2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.grey2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(4),
        borderSide: BorderSide(
          color: AppColor.grey2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(4),
        borderSide: const BorderSide(
          color: AppColor.primaryOrange,
        ),
      ),
      constraints: BoxConstraints(
        minHeight: 46.h,
      ),
    );
    final wid = type == TextFieldType.text
        ? ReactiveTextField(
            autofillHints: autofillHints,
            contextMenuBuilder: (context, editableTextState) {
              final items = editableTextState.contextMenuButtonItems;
              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: editableTextState.contextMenuAnchors,
                buttonItems: items,
              );
            },
            // onTapOutside: (controller) {
            //   FocusManager.instance.primaryFocus?.unfocus();
            // },
            textInputAction: inputType == TextInputType.multiline
                ? TextInputAction.newline
                : null,
            formControl: control,
            onEditingComplete: onEditDone == null
                ? null
                : (controller) {
                    onEditDone?.call();
                  },
            onTap: onTap == null
                ? null
                : (controller) {
                    onTap!.call();
                  },
            keyboardType: inputType,
            maxLines: maxLines,
            inputFormatters: [
              ...?inputFormatter,
              if (inputType == TextInputType.phone)
                FilteringTextInputFormatter.digitsOnly
            ],
            obscureText: obscure,
            style: AppFont.textFiled,
            textAlignVertical: iconButton != null
                ? TextAlignVertical.center
                : TextAlignVertical.top,
            formControlName: formControlName,
            decoration: decoration,
            validationMessages: validation,
            onChanged: onChanged,
          )
        : ReactiveDropdownField(
            hint: Text(
              "$hintText",
              style: AppFont.hintTextField,
            ),
            iconEnabledColor: AppColor.grey700,
            iconSize: 30,
            iconDisabledColor: AppColor.disabled,
            itemHeight: kMinInteractiveDimension,
            icon: ignore && hideSelectableIconIfIgnore
                ? const SizedBox.shrink()
                : null,
            formControl: formControlName != null ? null : control,
            onTap: onTap == null
                ? null
                : (controller) {
                    onTap!.call();
                  },
            onChanged: onChanged,
            style: AppFont.textFiled,
            formControlName: formControlName,
            decoration: decoration,
            items: items!,
            validationMessages: validation,
          );
    return Column(
      children: [
        if (labelText != null)
          Align(
            alignment: const AlignmentDirectional(-1, 0),
            child: Text(
              labelText!,
              style: AppFont.labelTextField,
              textAlign: TextAlign.start,
            ),
          ),
        InkWell(
          onTap: ignore ? onTap : null,
          child: IgnorePointer(
            ignoring: ignore,
            child: wid,
          ),
        ),
      ],
    );
  }
}

abstract class AppColor {
  static const Color primaryOrange = AppColors.primaryColorSALEK1;
  static const Color primaryGreen = Color(0xff58BB47);
  static const Color primaryPurple = Color(0xff7d4e9c);
  static const Color primaryCyan = Color(0xff62c7f1);
  static const Color secondaryPurple = Color(0xff9771b0);
  static const Color secondaryGreen = Color(0xff79c96c);
  static const Color secondaryCyan = Color(0xff81d2f4);
  static const Color secondaryOrange = Color(0xfff88f50);
  static const Color tertiaryOrange = Color(0xfffde3d3);
  static const Color dividerColor = Color(0xffEEEEEE);
  static const Color tertiaryGreen = Color(0xffdef1da);
  static const Color tertiaryPurple = Color(0xffe5dceb);
  static const Color tertiaryCyan = Color(0xffe0f4fc);
  static const Color otherBlack800 = Color(0xff0d1a1c);
  static const Color otherWhite = Colors.white;
  static const Color otherRed = Color(0xfff62424);
  static const Color otherYellow = Color(0xffffd33c);
  static const Color grey700 = Color(0xff736d6d);
  static const Color grey400 = Color(0xffd9d9d9);
  static const Color grey200 = Color(0xffebebeb);
  static const Color black800 = Color(0xff0D1A1C);
  static const Color grayAppBar = Color(0xff736F6F);
  static const Color greyBackgroundOnboarding = Color(0xfff8f8f8);

  //##########

  static Color get green2 => Get.isDarkMode ? green : greenDark;
  static const Color primaryDark = Color(0xff2EC1D1);

  static Color get white => Get.isDarkMode ? Colors.black : Colors.white;

  static Color get nearlyWhite =>
      Get.isDarkMode ? const Color(0xff232323) : Colors.white;

  static Color get grey3 =>
      Get.isDarkMode ? const Color(0xff777777) : Colors.white;

  static Color get grey_3 =>
      Get.isDarkMode ? const Color(0xff929898) : const Color(0xffD9D9D9);

  static Color get gray_3 =>
      Get.isDarkMode ? const Color(0xff777777) : const Color(0xffD9D9D9);

  static Color get whiteOrGrey =>
      Get.isDarkMode ? const Color(0xff929898) : Colors.white;

  static Color get black => Get.isDarkMode ? Colors.white : Colors.black;
  static const Color green = Color(0xff1D8E13);
  static const Color greenDark = Color(0xff42FF31);
  static Color danger = const Color(0xffE34E00);
  static const Color primary = primaryOrange;

  static Color get shipmentTileColor =>
      Get.isDarkMode ? const Color(0xff2f2f2f) : Colors.white;

  static Color get backGround => Colors.white;

  static Color get disabled =>
      Get.isDarkMode ? const Color(0xff9EACAD) : const Color(0xffC0CDCE);

  static Color get grey2 =>
      Get.isDarkMode ? const Color(0xff929898) : const Color(0xff656969);

  static Color get grey1 =>
      Get.isDarkMode ? const Color(0xffeaf3ff) : const Color(0xffd0d9e5);
  static const unselectedNavBar = Color(0xff707070);
}

abstract class AppFont {
  static TextStyle get _font => GoogleFonts.cairo();


  static TextStyle get font24W700PrimaryOrangeQuickSand => _font.copyWith(
        fontSize: 24.sp,
        color: AppColor.primaryOrange,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get font15W500Grey700 => _font.copyWith(
        fontSize: 15.sp,
        color: AppColor.grey700,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get font15W500Black => _font.copyWith(
        fontSize: 15.sp,
        color: AppColor.black,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get font16W700Grey700 => _font.copyWith(
        fontSize: 16.sp,
        color: AppColor.grey700,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get font12W500PrimaryOrange => _font.copyWith(
        fontSize: 12.sp,
        color: AppColor.primaryOrange,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get font14W500Primary => _font.copyWith(
        fontSize: 14.sp,
        color: AppColor.primaryOrange,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get font12W400PrimaryOrange => _font.copyWith(
        fontSize: 12.sp,
        color: AppColor.primaryOrange,
        fontWeight: FontWeight.w400,
      );


  static TextStyle get font15W700PrimaryOrange => _font.copyWith(
        fontSize: 15.sp,
        color: AppColor.primaryOrange,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get font20W600White => _font.copyWith(
        fontSize: 20.sp,
        color: AppColor.white,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get labelTextField => _font.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );


  static TextStyle get font16W500WhitePoppins => _font.copyWith(
        fontSize: 16.sp,
        color: AppColor.white,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get hintTextField => _font.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.grey700,
      );


  static TextStyle get font20W700NearlyWhite => _font.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColor.nearlyWhite,
      );

  static TextStyle get font18W700NearlyWhite => _font.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColor.nearlyWhite,
      );

  static TextStyle get font20W700Primary => _font.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColor.primary,
      );

  static TextStyle get textFiled => _font.copyWith(
        fontSize: 14.sp,
        color: AppColor.primary,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get font12Regular => _font.copyWith(
        fontSize: 12.sp,
      );



  static TextStyle get font16W700Primary => _font.copyWith(
        fontSize: 16.sp,
        color: AppColor.primary,
        fontWeight: FontWeight.w700,
      );



}
