import 'package:flag/flag.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/extensions/padding_extentions.dart';

import '../Common/square_text_field.dart';

class PhoneFormField extends StatelessWidget {
  final TextEditingController? controller;

  final String? label;

  final void Function(String)? onchange;

  const PhoneFormField({
    this.controller,
    this.onchange,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SquareTextField(
        textLetterSpaceing: 2,
        preFixWidget: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            3.pw,
            Container(
                width: 30.h,
                height: 50.w,
                child: Flag.fromString('SA', height: 1, width: 1)),
            2.pw,
            Text(
              "+966",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: kTextColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
          ],
        ),
        maxLength: 9,
        suffixWidget: Padding(
          padding: EdgeInsets.all(2.h),
          child: SvgPicture.asset(
            "assets/icons/lock_icon.svg",
            width: 10.h,
            height: 10.h,
          ),
        ),
        textStyle: GoogleFonts.tajawal(
          fontSize: 14.sp,
          color: kTextColor,
          fontWeight: FontWeight.normal,
        ),
        hintText: "رقم الهاتف",
        hintStyle: GoogleFonts.tajawal(
          fontSize: 14.sp,
          color: kDarkGreyColor,
          fontWeight: FontWeight.normal,
        ),
        controller: controller,
        validator: (value) {
          String pattern = r'[0-9]';
          RegExp regExp = RegExp(pattern);

          if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
            return "من فضلك أدخل رقم هاتف صحيح";
          }
          if (value.length != 9) {
            return "رقم الهاتف يجب أن يكون 9 أرقام";
          }

          return null;
        },
        /*controller: inst.phoneNumberController,*/
        onChanged: onchange,
        keyBoardType: TextInputType.phone,
      ),
    );
  }
}
