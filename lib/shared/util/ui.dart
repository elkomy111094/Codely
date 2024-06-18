import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:toastification/toastification.dart';

import '../../../../main.dart';
import '../Common/custom_text_button.dart';

enum MessageType { error, success, warning }

class UI {
  static push(page, {arguments}) async {
    return await Navigator.of(navigatorKey.currentContext!)
        .pushNamed(page, arguments: arguments);
  }

  static pushReplacement(page, {arguments}) async {
    return await Navigator.of(navigatorKey.currentContext!)
        .pushReplacementNamed(page, arguments: arguments);
  }

  static void pop() {
    Navigator.of(navigatorKey.currentContext!).pop();
  }

  static void pushWithRemove(page, {arguments}) {
    Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
      page,
      (_) => false,
      arguments: arguments,
    );
  }

  static void showPopup(message,
      {String? btnOkText,
      DialogType type = DialogType.error,
      Function? callBack}) {
    AwesomeDialog(
      context: navigatorKey.currentContext!,
      dialogType: type,
      animType: AnimType.scale,
      desc: message,
      padding: EdgeInsets.only(top: 20.h),
      descTextStyle: GoogleFonts.tajawal(
        fontSize: 18.sp,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
      btnOk: CustomTextButton(
        text: btnOkText ?? "نعم",
        borderColor: Colors.red,
        textColor: Colors.red,
        onPressed: () => callBack != null ? callBack() : pop(),
      ),
      btnCancel: CustomTextButton(
        text: "لا",
        borderColor: kgreenColor,
        textColor: kgreenColor,
        onPressed: () => pop(),
      ),
    ).show();
  }

  static void showAlert(context, {message, type}) {
    Toastification().show(
      context: context,
      title: Text(
        message ?? "",
        textAlign: TextAlign.center,
        style: GoogleFonts.tajawal(
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      autoCloseDuration: const Duration(seconds: 4),
      backgroundColor: type == MessageType.error
          ? Colors.redAccent
          : type == MessageType.success
              ? Colors.green
              : type == MessageType.warning
                  ? Colors.amber
                  : Colors.green[200],
    );
  }

  void showCustomBottomSheet(
      {required Widget child,
      required BuildContext context,
      bool? closedButton,
      double? bottomSheetHeight}) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: kBlueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.h), topLeft: Radius.circular(5.h)),
        ),
        context: context,
        builder: (builder) {
          return Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20.h),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      closedButton != true
                          ? SizedBox()
                          : InkWell(
                              onTap: () {
                                UI.pop();
                              },
                              child: Container(
                                width: 50.h,
                                height: 50.h,
                                child: Padding(
                                  padding: EdgeInsets.all(1.h),
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                    size: 15.sp,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                      closedButton != true
                          ? Spacer()
                          : SizedBox(
                              width: 250.w,
                            ),
                      Center(
                        child: Container(
                          width: 150.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.2),
                            borderRadius: BorderRadius.circular(5.h),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Center(child: child),
                ),
              ),
            ],
          );
        });
  }
}
