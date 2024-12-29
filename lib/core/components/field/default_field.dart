import 'package:flutter/material.dart';

import '../../constant/constant.dart';

class DefaultField extends StatelessWidget {
  const DefaultField({
    super.key,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.isEnabled = true,
    this.readOnly = false,
    this.controller,
    this.onChanged,
    this.intialText,
    this.isObscure = false,
    this.maxLines = 1,
    this.inputType,
    this.backgroundColor = AppColors.whiteColor,
    this.textAlign = TextAlign.start,
    this.validator,
  });

  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final bool isEnabled;
  final bool readOnly;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? intialText;
  final bool isObscure;
  final int maxLines;
  final TextInputType? inputType;
  final Color? backgroundColor;
  final TextAlign textAlign;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextFormField(
        validator: validator,
        enabled: isEnabled,
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged ?? (value) {},
        textAlign: textAlign,
        cursorColor: AppColors.blackColor,
        initialValue: intialText,
        style: AppText.text14.copyWith(color: AppColors.blackColor),
        keyboardType: inputType,
        obscureText: isObscure,
        maxLines: maxLines,
        decoration: InputDecoration(
          focusColor: AppColors.blackColor,
          contentPadding: const EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: AppText.text14.copyWith(
              color: AppColors.blackColor, fontWeight: FontWeight.bold),
          labelText: labelText,
          labelStyle: AppText.text14,
          floatingLabelStyle: AppText.text14,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
          prefixIcon: prefixIcon,
          prefixIconConstraints: prefixIconConstraints,
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIconConstraints,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
          fillColor: AppColors.primaryColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
