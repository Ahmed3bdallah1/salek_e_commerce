import 'package:car_rentting/core/functions/responsive.dart';
import 'package:car_rentting/core/utils/app_fonts.dart';
import 'package:car_rentting/core/utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum TextFieldType { text, selectable }

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.formControlName,
    this.inputType = TextInputType.text,
    this.style = 1,
    this.inputformatter,
    this.paddingfromtop = false,
    this.onEditDone,
    this.ontap,
    this.obscure = false,
    this.maxlines = 1,
    this.control,
    this.iconDataPrefix,
    this.iconColor = Colors.grey,
    this.iconButton,
    this.type = TextFieldType.text,
    this.items,
    this.onChanged,
    this.borderRadius,
    this.controller,
    this.ignore = false,
    this.labelText,
  });

  final String? formControlName;
  final FormControl? control;
  final String? hintText;
  final String? labelText;
  final int style;
  final Widget? iconButton;
  final bool obscure;
  final bool ignore;
  final int maxlines;
  final VoidCallback? onEditDone;
  final bool paddingfromtop;
  final List<TextInputFormatter>? inputformatter;
  final TextInputType inputType;
  final void Function()? ontap;
  final TextFieldType type;
  final List<DropdownMenuItem<dynamic>>? items;
  final Widget? iconDataPrefix;
  final Color iconColor;
  final ValueChanged? onChanged;
  final BorderRadius? borderRadius;
  final AbstractControl? controller;

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    //TODO: implement build
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
      "validation_the_same": (controller) => "validation_the_same".tr,
    };
    final InputDecoration decoration = InputDecoration(
      hintStyle: AppFontStyle.grey_14,
      labelStyle: AppFontStyle.grey_14,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      filled: false,
      suffixIcon: iconButton,
      prefixIcon: iconDataPrefix,
      hintText: hintText,
      labelText: labelText,
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.lightColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.lightColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            // color: AppColors.lightColor,
            ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            // color: AppColors.lightColor,
            ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      constraints: BoxConstraints(
        minHeight: 70.h,
      ),
    );
    final wid = type == TextFieldType.text
        ? ReactiveTextField(
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
            onTap: ontap == null
                ? null
                : (controller) {
                    ontap!.call();
                  },
            keyboardType: inputType,
            maxLines: maxlines,
            inputFormatters: inputformatter,
            obscureText: obscure,
            textAlignVertical: iconButton != null
                ? TextAlignVertical.center
                : TextAlignVertical.top,
            formControlName: formControlName,
            decoration: decoration,
            validationMessages: validation,
            onChanged: onChanged,
          )
        : ReactiveDropdownField(
            iconEnabledColor: Colors.black,
            iconDisabledColor: AppColors.lightColor,
            itemHeight: kMinInteractiveDimension,
            isDense: false,
            formControl: formControlName != null
                ? null
                : controller != null
                    ? controller as FormControl
                    : control,
            onTap: ontap == null
                ? null
                : (controller) {
                    ontap!.call();
                  },
            onChanged: onChanged,
            dropdownColor: Colors.white,
            formControlName: formControlName,
            decoration: decoration,
            items: items!,
            validationMessages: validation,
          );
    return Column(
      children: [
        InkWell(
          onTap: ignore ? ontap : null,
          child: IgnorePointer(
            ignoring: ignore,
            child: wid,
          ),
        ),
      ],
    );
  }
}
