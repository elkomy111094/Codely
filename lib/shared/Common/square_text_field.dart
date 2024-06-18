import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/constants/colors.dart';

class SquareTextField extends StatelessWidget {
  String hintText;
  Widget? suffixWidget;
  int? maxLines;
  Widget? preFixWidget;
  String? Function(String?)? validator;
  String? Function(String?)? onSubmit;
  final TextEditingController? phoneController;

  void Function(String)? onChanged;

  TextEditingController? controller;

  bool obsecureance;

  Brightness? keyBoardAppearance;

  TextInputType? keyBoardType;

  Color? fillColor;

  int? maxLength;

  String? prefixText;

  double? textLetterSpaceing;

  TextStyle? textStyle;

  TextStyle? hintStyle;

  TextAlign? textAlign;

  String? labelText;

  bool? enableState;

  Widget? postFix;

  double? borderRadius;

  double? hContentPadding;

  double? vContentPadding;

  SquareTextField({
    required this.hintText,
    this.labelText,
    this.hContentPadding,
    this.vContentPadding,
    this.textLetterSpaceing = 0.0,
    this.enableState,
    this.hintStyle,
    this.borderRadius,
    this.postFix,
    this.textStyle,
    this.maxLength,
    this.onSubmit,
    this.prefixText,
    this.textAlign,
    this.preFixWidget,
    this.fillColor = Colors.white60,
    this.maxLines = 1,
    this.phoneController,
    this.keyBoardType,
    this.controller,
    this.validator,
    this.keyBoardAppearance,
    this.obsecureance = false,
    this.suffixWidget,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: TextFormField(
            textAlign: textAlign ?? TextAlign.start,
            cursorColor: kgreenColor,
            onChanged: onChanged,
            validator: validator,
            keyboardType: keyBoardType,
            keyboardAppearance: keyBoardAppearance,
            controller: controller,
            maxLines: maxLines,
            maxLength: maxLength,
            obscuringCharacter: "•",
            obscureText: obsecureance,
            onFieldSubmitted: onSubmit,
            enabled: enableState,
            style: textStyle ??
                TextStyle(
                    color: Colors.black,
                    fontFamily: "Taga",
                    letterSpacing: textLetterSpaceing,
                    fontSize: 11.sp),
            decoration: InputDecoration(
              border: InputBorder.none,
              errorStyle: TextStyle(fontSize: 10.sp, fontFamily: "Taga"),
              fillColor: fillColor,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                  vertical: vContentPadding ?? 2.3.h,
                  horizontal: hContentPadding ?? 3.w),
              prefixText: prefixText,
              prefixStyle: TextStyle(
                  color: kgreenColor,
                  fontWeight: FontWeight.bold,
                  /*fontFamily: "Taga",*/
                  fontSize: 13.sp),
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hintText,
              counterText: "",
              suffixIcon: suffixWidget,
              alignLabelWithHint: true,
              floatingLabelStyle: TextStyle(
                fontSize: 11.sp,
                letterSpacing: 0,
                fontFamily: "Taga",
                color: kBlueColor,
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 11.sp,
                letterSpacing: 0,
                fontFamily: "Taga",
              ),
              prefixIcon: preFixWidget,
              hintStyle: hintStyle ??
                  TextStyle(color: Colors.black26, fontSize: 11.sp),
            ),
          ),
        ),
      ),
    );
  }
}
