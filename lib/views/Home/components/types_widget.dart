import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/util/app_routes.dart';
import 'package:smart_shoper_master/shared/util/ui.dart';
import 'package:smart_shoper_master/view_models/favorites_view_model.dart';

import '../../../models/category_model.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';

class TypesWidget extends StatelessWidget {
  TypesWidget({
    Key? key,
    required this.favoritesViewModel,
    required this.typeList,
  }) : super(key: key);
  final FavoritesViewModel favoritesViewModel;
  final List<CategoryModel> typeList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      width: double.infinity,
      child: ListView.separated(
        padding: EdgeInsets.only(right: 33.w),
        scrollDirection: Axis.horizontal,
        itemCount: typeList.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 53.w,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              UI.push(AppRoutes.categoriesView,
                  arguments: [favoritesViewModel, typeList?[index]]);
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundColor: kgreenColor.withOpacity(.3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      width: 100.w,
                      height: 100.w,
                      imageUrl: typeList?[index].image ?? "",
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, __) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                FittedBox(
                  child: Text(
                    typeList[index].name,
                    style: GoogleFonts.tajawal(
                      fontSize: 14.sp,
                      color: kTextColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
