import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_shoper_master/models/cupon_model.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/util/ui.dart';

class CodeWidget extends StatelessWidget {
  CuponModel? cupon;

  CodeWidget({
    Key? key,
    required this.cupon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('تم نسخ الكود'),
    );

    return GestureDetector(
      onTap: () {
        showMaterialModalBottomSheet(
          backgroundColor: kLightGreenColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.r),
                  topLeft: Radius.circular(30.r))),
          context: context,
          builder: (context) => ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Container(
              height: 600.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 70.h, horizontal: 30.w),
              child: Stack(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      "assets/images/big_coupon.svg",
                      height: 464.h,
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60.h,
                        ),
                        CircleAvatar(
                          radius: 30.r,
                          backgroundColor: kgreenColor.withOpacity(.3),
                          backgroundImage: NetworkImage(cupon!.store.logo),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            cupon!.name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.tajawal(
                              fontSize: 16.sp,
                              color: kTextColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        SizedBox(
                          height: 61.h,
                          width: 500.w,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  "assets/icons/coupon.svg",
                                  height: 61.h,
                                  width: 500,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Center(
                                child: Text(
                                  cupon!.code,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 24.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Text(
                            cupon!.desc,
                            style: GoogleFonts.tajawal(
                              fontSize: 16.sp,
                              color: kTextColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80.h,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: cupon!.code))
                                .then((value) {
                              UI.pop();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          },
                          child: Text(
                            "نسخ الكود",
                            style: GoogleFonts.tajawal(
                              fontSize: 16.sp,
                              color: kBlueColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        width: 391.w,
        height: 170.h,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 4.h,
        ),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 5,
              spreadRadius: 2,
              color: kGreyColor,
            ),
          ],
          borderRadius: BorderRadius.circular(12.r),
          color: kLightGreyColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/coupon2.svg",
                  height: 36.h,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Row(
                  children: [
                    Text(
                      cupon!.name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.tajawal(
                        fontSize: 16.sp,
                        color: kTextColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            SvgPicture.asset(
              "assets/icons/hiden_code.svg",
              width: 274.h,
              height: 43.w,
            ),
            SizedBox(
              height: 13.h,
            ),
            const DottedLine(
              direction: Axis.horizontal,
              lineLength: double.infinity,
              lineThickness: 1.0,
              dashLength: 4.0,
              dashColor: kDarkGreyColor,
            ),
            SizedBox(
              height: 7.h,
            ),
            Container(
              height: 50.h,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/cachback.svg",
                    height: 34.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Text(
                      cupon!.desc,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.tajawal(
                        fontSize: 16.sp,
                        color: kTextColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
