import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';
import 'package:smart_shoper_master/view_models/favorites_view_model.dart';
import 'package:smart_shoper_master/view_models/stores_view_model.dart';

import '../../../shared/Common/loading_widget.dart';
import '../../../shared/Common/notification_widget.dart';
import '../../../shared/Common/offer_widget.dart';
import '../../../shared/Common/profile_widget.dart';
import '../../../shared/Common/title_widget.dart';
import '../../../shared/util/app_routes.dart';
import '../../../shared/util/ui.dart';
import '../../../shared/widgets/no_data_widget.dart';
import '../../Home/components/types_widget.dart';

class StoresView extends StatelessWidget {
  StoresView(
      {Key? key,
      required this.favoritesViewModel,
      required this.storesViewModel})
      : super(key: key);
  StoresViewModel storesViewModel;
  FavoritesViewModel favoritesViewModel;
  int slideIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: storesViewModel.storesCubit,
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
                      "المتاجر",
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
                          height: 24.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          height: 59.h,
                          width: 388.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(color: kGreyColor),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  "assets/icons/loop_icon.svg",
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: storesViewModel.searchController,
                                  maxLines: 1,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 18.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  onChanged: (phone) {},
                                  onSubmitted: (val) {
                                    if (storesViewModel
                                        .searchController.text.isNotEmpty) {
                                      UI.push(AppRoutes.searchResultScreen,
                                          arguments: storesViewModel);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "وش تفكر لا تحتار …",
                                    hintStyle: GoogleFonts.tajawal(
                                      fontSize: 18.sp,
                                      color: kDarkGreyColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 23.h,
                        ),
                        const TitleWidget(title: "كل الفئات"),
                        SizedBox(
                          height: 15.h,
                        ),
                        TypesWidget(
                          typeList: storesViewModel.categoriesList ?? [],
                          favoritesViewModel: favoritesViewModel,
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        const TitleWidget(title: "متاجر موصي بها"),
                        SizedBox(
                          height: 23.h,
                        ),
                        storesViewModel.recommendedStoresList != null
                            ? storesViewModel.recommendedStoresList!.isEmpty
                                ? NoDataWidget(title: "قائمه فارغه")
                                : SizedBox(
                                    height: 220.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      padding: EdgeInsets.only(right: 33.w),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: storesViewModel
                                          .recommendedStoresList!.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          width: 16.w,
                                        );
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return OfferWidget(
                                          isVerticle: false,
                                          isCachBack: false,
                                          favoritesViewModel:
                                              favoritesViewModel,
                                          store: storesViewModel
                                              .recommendedStoresList![index],
                                        );
                                      },
                                    ),
                                  )
                            : Center(
                                child: Loading(),
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        const TitleWidget(title: "متاجر قد تعرفها"),
                        SizedBox(
                          height: 28.h,
                        ),
                        storesViewModel.moreChoicesStoresList != null
                            ? storesViewModel.moreChoicesStoresList!.isEmpty
                                ? NoDataWidget(title: "قائمه فارغه")
                                : SizedBox(
                                    height: 81.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      padding: EdgeInsets.only(right: 33.w),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: storesViewModel
                                          .moreChoicesStoresList!.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          width: 16.w,
                                        );
                                      },
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            UI.push(
                                                AppRoutes.offerDetailsScreen,
                                                arguments: [
                                                  storesViewModel
                                                          .moreChoicesStoresList![
                                                      index],
                                                  favoritesViewModel
                                                ]);
                                          },
                                          child: Container(
                                            height: 81.h,
                                            width: 81.h,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kLightGreyColor,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(1000.r),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl: storesViewModel
                                                    .moreChoicesStoresList![
                                                        index]
                                                    .logo,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget: (context, url,
                                                        __) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                            : Center(
                                child: Loading(),
                              ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const TitleWidget(title: "كل المتاجر"),
                        SizedBox(
                          height: 23.h,
                        ),
                        storesViewModel.allStoresList != null
                            ? storesViewModel.allStoresList!.isEmpty
                                ? NoDataWidget(title: "قائمه فارغه")
                                : SizedBox(
                                    child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          storesViewModel.allStoresList!.length,
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
                                          store: storesViewModel
                                              .allStoresList![index],
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
