import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/models/rate_model.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';

class ReviewWidget extends StatelessWidget {
  ReviewWidget({Key? key, required this.rate}) : super(key: key);
  final RateModel rate;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 391.w,
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
          color: kLightGreyColor, borderRadius: BorderRadius.circular(25.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 80.h,
            width: 80.w,
            decoration: BoxDecoration(
              color: kGreyColor,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                width: 100.w,
                height: 100.w,
                imageUrl:
                    "https://static.vecteezy.com/system/resources/previews/017/442/998/non_2x/male-paramedic-avatar-character-icon-free-vector.jpg",
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, __) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rate.user.firstName + " " + rate.user.lastName,
                      style: GoogleFonts.tajawal(
                        fontSize: 14.sp,
                        color: kTextColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                      // width: 70.w,
                      child: RatingBar.builder(
                        initialRating: rate.rate.toDouble(),
                        minRating: 1,
                        itemSize: 15.sp,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 5.sp,
                        ),
                        onRatingUpdate: (double value) {},
                        updateOnDrag: false,
                        ignoreGestures: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/clock.svg",
                      height: 14.h,
                    ),
                    SizedBox(
                      width: 6.h,
                    ),
                    Text(
                      "${GetTimeAgo.parse(DateTime.parse(rate.createdAt))}",
                      style: GoogleFonts.tajawal(
                        fontSize: 12.sp,
                        color: kDarkGreyColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/vline.svg",
                      height: 25.h,
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    Flexible(
                      child: Text(
                        rate.message,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: GoogleFonts.tajawal(
                          fontSize: 12.sp,
                          color: kDarkGreyColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
