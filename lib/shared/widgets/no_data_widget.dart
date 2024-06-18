import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataWidget extends StatelessWidget {
  NoDataWidget({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/no_data.svg",
                width: 200.h,
                height: 200.h,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(
                    fontSize: 14.sp,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
