import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';
import 'package:smart_shoper_master/view_models/favorites_view_model.dart';
import 'package:smart_shoper_master/view_models/offers_view_model.dart';

import '../../../shared/Common/loading_widget.dart';
import '../../../shared/Common/notification_widget.dart';
import '../../../shared/Common/offer_widget.dart';
import '../../../shared/Common/profile_widget.dart';
import '../../../shared/Common/title_widget.dart';
import '../../../shared/widgets/no_data_widget.dart';

class OffersView extends StatefulWidget {
  OffersView(
      {Key? key,
      required this.favoritesViewModel,
      required this.offersViewModel})
      : super(key: key);
  OffersViewModel offersViewModel;
  FavoritesViewModel favoritesViewModel;

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: widget.offersViewModel.offersCubit,
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
                      "العروض",
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        const TitleWidget(title: "افضل العروض لك"),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 220.h,
                          width: double.infinity,
                          child: widget.offersViewModel.bestOffersList != null
                              ? widget.offersViewModel.bestOffersList!.isEmpty
                                  ? NoDataWidget(title: "لاتوجد أي عروض")
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(right: 33.w),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.offersViewModel
                                          .bestOffersList!.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          width: 14.w,
                                        );
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return OfferWidget(
                                          isVerticle: false,
                                          isCachBack: false,
                                          favoritesViewModel:
                                              widget.favoritesViewModel,
                                          store: widget.offersViewModel
                                              .bestOffersList![index],
                                        );
                                      },
                                    )
                              : Center(
                                  child: Loading(),
                                ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const TitleWidget(title: "افضل العروض"),
                        SizedBox(
                          height: 23.h,
                        ),
                        widget.offersViewModel.bestOffersList != null
                            ? widget.offersViewModel.bestOffersList!.isEmpty
                                ? NoDataWidget(title: "قائمه فارغه")
                                : SizedBox(
                                    child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: widget.offersViewModel
                                          .bestOffersList!.length,
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
                                              widget.favoritesViewModel,
                                          store: widget.offersViewModel
                                              .bestOffersList![index],
                                        );
                                      },
                                    ),
                                  )
                            : Center(
                                child: Loading(),
                              ),
                      ],
                    ),
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
