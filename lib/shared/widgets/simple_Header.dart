import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/constants/colors.dart';
import '../util/ui.dart';

class SimpleHeader extends StatelessWidget {
  bool? showPopIconButton;
  String headerTitle;
  Color? headerColor;

  SimpleHeader(
      {required this.headerTitle,
      this.showPopIconButton = true,
      this.headerColor});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 90.h,
        decoration: BoxDecoration(
          color: kLightGreenColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(headerTitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.tajawal(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
              showPopIconButton!
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: GestureDetector(
                        onTap: () {
                          UI.pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 13.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
