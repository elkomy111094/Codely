import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/shared/Common/loading_widget.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/widgets/no_data_widget.dart';
import 'package:smart_shoper_master/view_models/favorites_view_model.dart';

import '../../../shared/Common/notification_widget.dart';
import '../../../shared/Common/offer_widget.dart';
import '../../../shared/Common/profile_widget.dart';
import '../../../shared/Common/title_widget.dart';
import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/util/app_routes.dart';
import '../../../shared/util/ui.dart';
import '../../../view_models/home_view_model.dart';
import '../components/types_widget.dart';

class HomeView extends StatefulWidget {
  HomeView(
      {Key? key, required this.homeViewModel, required this.favoritesViewModel})
      : super(key: key);
  final HomeViewModel homeViewModel;
  FavoritesViewModel favoritesViewModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int slideIndex = 0;

  @override
  void initState() {
    widget.homeViewModel.getHomeData();
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 23.h : 5.h,
      width: 5.h,
      decoration: isCurrentPage
          ? BoxDecoration(
              color: kgreenColor,
              gradient: kVerticalGradiant,
              borderRadius: BorderRadius.circular(12),
            )
          : BoxDecoration(
              color: kGreyColor,
              borderRadius: BorderRadius.circular(12),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: widget.homeViewModel.homeCubit,
      listener: (context, state) {
        if (state is GenericErrorState) {
          UI.showAlert(
            context,
            message: state.responseError?.message ?? "",
            type: MessageType.error,
          );
        } else if (state is GenericUpdatedState) {
        } else if (state is GenericSucessRequestState) {}
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kLightGreenColor,
          body: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Container(
                height: 36.h,
                width: 367.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ProfileWidget(),
                    Text(
                      "الرئيسيه",
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
                        /* SizedBox(
                          width: 346.w,
                          height: 25.h,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  "assets/icons/home_location.svg"),
                              SizedBox(
                                width: 27.h,
                              ),
                              Text(
                                "موقعك الحالي",
                                style: GoogleFonts.tajawal(
                                  fontSize: 16.sp,
                                  color: kDarkGreyColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Flexible(
                                child: Text(
                                  "7251 مدائن الفهد , 2483 حي ، 7251 مدائن الفهد ، جده 22347 السعوديه",
                                  style: GoogleFonts.tajawal(
                                    fontSize: 16.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: 10.h,
                              ),
                              InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  "assets/icons/chevron_down_button.svg",
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        SizedBox(
                          height: 14.h,
                        ),
                        widget.homeViewModel.slidersList != null
                            ? widget.homeViewModel.slidersList!.isEmpty
                                ? Container(
                                    width: 387.w,
                                    height: 170.h,
                                    child: NoDataWidget(
                                        title: "لاتوجد أي إعلانات"))
                                : Container(
                                    width: 387.w,
                                    height: 170.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13.r),
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(13.r),
                                          child: Swiper(
                                            containerHeight: 162.h,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13.r),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.fill,
                                                    imageUrl: widget
                                                            .homeViewModel
                                                            .slidersList?[index]
                                                            .image ??
                                                        "",
                                                    placeholder: (context,
                                                            url) =>
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
                                              );
                                            },
                                            loop: true,
                                            duration: 1000,
                                            itemCount: 3,
                                            index: slideIndex,
                                            autoplay: true,
                                            layout: SwiperLayout.DEFAULT,
                                            onIndexChanged: (index) {
                                              setState(() {
                                                slideIndex = index;
                                              });
                                            },
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                for (int i = 0; i < 3; i++)
                                                  i == slideIndex
                                                      ? _buildPageIndicator(
                                                          true)
                                                      : _buildPageIndicator(
                                                          false),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                            : Center(
                                child: Container(
                                    width: 387.w,
                                    height: 170.h,
                                    child: Center(child: Loading())),
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
                                  controller:
                                      widget.homeViewModel.searchController,
                                  maxLines: 1,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 18.sp,
                                    color: kTextColor,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  onChanged: (phone) {},
                                  onSubmitted: (val) {
                                    if (widget.homeViewModel.searchController
                                        .text.isNotEmpty) {
                                      UI.push(AppRoutes.searchResultScreen,
                                          arguments: [
                                            widget.homeViewModel,
                                            widget.favoritesViewModel
                                          ]);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "وش تفكر لا تحتار …",
                                    hintStyle: GoogleFonts.tajawal(
                                      fontSize: 16.sp,
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
                          typeList: widget.homeViewModel.categoriesList ?? [],
                          favoritesViewModel: widget.favoritesViewModel,
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        const TitleWidget(title: "عروض لاتفوتها"),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          height: 220.h,
                          width: double.infinity,
                          child: widget.homeViewModel.unMissableStoresList !=
                                  null
                              ? widget.homeViewModel.unMissableStoresList!
                                      .isEmpty
                                  ? NoDataWidget(title: "لاتوجد أي عروض")
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(right: 33.w),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.homeViewModel
                                          .unMissableStoresList!.length,
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
                                          store: widget.homeViewModel
                                              .unMissableStoresList![index],
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
                        const TitleWidget(title: "الأكثر اختيارا"),
                        SizedBox(
                          height: 28.h,
                        ),
                        widget.homeViewModel.moreChoicesStoresList != null
                            ? widget.homeViewModel.moreChoicesStoresList!
                                    .isEmpty
                                ? Center(
                                    child: NoDataWidget(title: "لاتوجد عناصر"))
                                : SizedBox(
                                    height: 81.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      padding: EdgeInsets.only(right: 33.w),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.homeViewModel
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
                                                  widget.homeViewModel
                                                          .moreChoicesStoresList![
                                                      index],
                                                  widget.favoritesViewModel
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
                                                imageUrl: widget
                                                    .homeViewModel
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
                        const TitleWidget(title: "متاجر موصى بها"),
                        SizedBox(
                          height: 23.h,
                        ),
                        widget.homeViewModel.recommendedStoresList != null
                            ? widget.homeViewModel.recommendedStoresList!
                                    .isEmpty
                                ? Center(
                                    child: NoDataWidget(title: "قائمه فارغه"))
                                : SizedBox(
                                    height: 220.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      padding: EdgeInsets.only(right: 33.w),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.homeViewModel
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
                                              widget.favoritesViewModel,
                                          store: widget.homeViewModel
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
                        const TitleWidget(title: "افضل العروض"),
                        SizedBox(
                          height: 23.h,
                        ),
                        widget.homeViewModel.bestOffersList != null
                            ? widget.homeViewModel.bestOffersList!.isEmpty
                                ? Center(
                                    child: NoDataWidget(title: "قائمه فارغه"))
                                : SizedBox(
                                    child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: widget
                                          .homeViewModel.bestOffersList!.length,
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
                                          store: widget.homeViewModel
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
