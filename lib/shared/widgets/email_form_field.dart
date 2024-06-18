import 'package:flutter/material.dart';
import 'package:smart_shoper_master/shared/extensions/string_extensions.dart';

import '../Common/square_text_field.dart';
import '../constants/styles.dart';

class EmailFormField extends StatelessWidget {
  final TextEditingController controller;

  String? label;

  String? hint;

  EmailFormField({
    required this.controller,
    this.hint,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SquareTextField(
      textLetterSpaceing: 2,
      labelText: label ?? "email".tr,
      textStyle: AppStyles.kTextStyle12.copyWith(fontFamily: "Montserrat"),
      hintText: hint ?? "",
      controller: controller,
      validator: (emailVal) {
        if (emailVal!.isEmpty) {
          return "من فضلك أدخل البريد الإلكتروني";
        } else if ((!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailVal!))) {
          return "من فضلك أدخل بريد الكتروني صحيح";
        } else {
          return null;
        }
      },
      /*controller: inst.phoneNumberController,*/
      onChanged: (phone) {},
      keyBoardType: TextInputType.emailAddress,
    );
  }
}
