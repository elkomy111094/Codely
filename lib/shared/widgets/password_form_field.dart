import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/extensions/string_extensions.dart';

import '../Common/square_text_field.dart';
import '../constants/styles.dart';
import '../resources.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  String? hint;

  String? label;

  PasswordFormField({
    required this.controller,
    this.hint,
    this.label,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return SquareTextField(
      textLetterSpaceing: 2,
      labelText: widget.label ?? "password".tr,
      controller: widget.controller,
      textStyle: AppStyles.kTextStyle12.copyWith(fontFamily: "Montserrat"),
      preFixWidget: Padding(
        padding: EdgeInsets.all(2.h),
        child: SvgPicture.asset(
          Resources.lockerIcon,
          width: 1.5.h,
          height: 1.5.h,
        ),
      ),
      maxLength: 12,
      suffixWidget: IconButton(
        onPressed: () {
          setState(() {
            obsecure = !obsecure;
          });
        },
        icon: Icon(
          obsecure ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
          color: kGreyColor,
          size: 15.sp,
        ),
      ),
      hintText: widget.hint ?? "",
      obsecureance: obsecure,
      validator: (passWord) {
        if (passWord!.isEmpty) {
          return "من فضلك أدخل كلمة المرور";
        } else if (passWord.length < 6) {
          return "كلمه المرور يجب أن تكون 6 أحرف أو أكثر";
        } else {
          return null;
        }
      },
      /*controller: inst.phoneNumberController,*/
      onChanged: (phone) {},
      keyBoardType: TextInputType.text,
    );
  }
}
