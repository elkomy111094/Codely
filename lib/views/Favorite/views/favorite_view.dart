import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';
import 'package:smart_shoper_master/view_models/favorites_view_model.dart';

import '../../../shared/Common/loading_widget.dart';
import '../../../shared/Common/notification_widget.dart';
import '../../../shared/Common/offer_widget.dart';
import '../../../shared/Common/profile_widget.dart';
import '../../../shared/widgets/no_data_widget.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({Key? key, required this.favoritesViewModel}) : super(key: key);
  FavoritesViewModel favoritesViewModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: favoritesViewModel.favoritesCubit,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kLightGreenColor,
          body: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                height: 36.h,
                width: 367.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ProfileWidget(),
                    Text(
                      "المفضله",
                      style: GoogleFonts.tajawal(
                        fontSize: 23.sp,
                        color: kTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const NotificationWidget(),
                  ],
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(43.r),
                      topRight: Radius.circular(43.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 23.h,
                      ),
                      Expanded(
                        //height: 220.h,
                        //width: double.infinity,
                        child: favoritesViewModel.favoritesList != null
                            ? favoritesViewModel.favoritesList!.isEmpty
                                ? Container(
                                    height: 300.h,
                                    width: 300.w,
                                    child: NoDataWidget(
                                        title: "لم تقم بإضافة أي شئ للمفضله"))
                                : SizedBox(
                                    child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      scrollDirection: Axis.vertical,
                                      itemCount: favoritesViewModel
                                          .favoritesList!.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          height: 14.w,
                                        );
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return OfferWidget(
                                          isVerticle: true,
                                          isCachBack: false,
                                          favoritesViewModel:
                                              favoritesViewModel,
                                          store: favoritesViewModel
                                              .favoritesList![index],
                                        );
                                      },
                                    ),
                                  )
                            : Center(
                                child: Loading(),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
