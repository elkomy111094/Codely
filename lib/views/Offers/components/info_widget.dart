import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/models/store_model.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';

class InfoWidget extends StatelessWidget {
  InfoWidget({
    Key? key,
    required this.store,
  }) : super(key: key);
  StoreModel store;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 221.h,
      width: 391.w,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 23.h,
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
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: kGreyColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: store!.logo,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, __) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            store.name,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.tajawal(
                              fontSize: 14.sp,
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  height: 90.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: Colors.white,
                    border: Border.all(color: kGreyColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/star2.svg",
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Text(
                        store.rate.toString(),
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.tajawal(
                          fontSize: 18.sp,
                          color: kTextColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Container(
                  height: 90.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: Colors.white,
                    border: Border.all(color: kGreyColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/store2.svg",
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      Text(
                        store.categories.isNotEmpty
                            ? store.categories[0].name
                            : "غير مصنف",
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.tajawal(
                          fontSize: 14.sp,
                          color: kTextColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
