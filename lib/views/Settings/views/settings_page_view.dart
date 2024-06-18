import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/widgets/simple_Header.dart';

import '../../../models/settings_data_model.dart';

class SettingsPageView extends StatelessWidget {
  Pages page;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleHeader(headerTitle: page.title),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(page.value,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.tajawal(
                                fontSize: 14.sp,
                                color: kTextColor,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SettingsPageView({required this.page});
}
