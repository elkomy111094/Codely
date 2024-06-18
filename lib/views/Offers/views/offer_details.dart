import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_shoper_master/models/store_model.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';
import 'package:smart_shoper_master/shared/widgets/no_data_widget.dart';
import 'package:smart_shoper_master/view_models/favorites_view_model.dart';
import 'package:smart_shoper_master/view_models/rates_view_model.dart';

import '../../../shared/Common/gradiant_button.dart';
import '../../../shared/Common/loading_widget.dart';
import '../../../shared/util/ui.dart';
import '../components/add_review.dart';
import '../components/code_widegt.dart';
import '../components/info_widget.dart';
import '../components/review_widget.dart';

class OfferDetailsView extends StatefulWidget {
  OfferDetailsView(
      {Key? key, required this.store, required this.favoritesViewModel})
      : super(key: key);
  StoreModel store;
  final FavoritesViewModel favoritesViewModel;

  @override
  State<OfferDetailsView> createState() => _OfferDetailsViewState();
}

class _OfferDetailsViewState extends State<OfferDetailsView> {
  bool isReviews = true;
  RatesViewModel ratesViewModel = RatesViewModel();

  @override
  void initState() {
    ratesViewModel.getStoreRates(widget.store.id).then((value) {
      if (value != null) ratesViewModel.checkIfUserRateBefore();
    });
    ratesViewModel.getStoreCupons(widget.store.id);
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.h), topRight: Radius.circular(50.h))),
      context: context,
      builder: (BuildContext context) {
        return Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: kLightGreenColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.h),
                    topRight: Radius.circular(50.h))),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    AddReviewWidget(
                      ratesViewModel: ratesViewModel,
                      storeId: widget.store.id,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<GenericCubit, GenericCubitState>(
        bloc: ratesViewModel.ratesCubit,
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<GenericCubit, GenericCubitState>(
            bloc: widget.favoritesViewModel.favoritesCubit,
            listener: (context, state) {
              if (state is GenericErrorState) {
                UI.showAlert(
                  context,
                  message: state.responseError!.message,
                  type: MessageType.error,
                );
              } else if (state is GenericUpdatedState) {
              } else if (state is GenericSucessRequestState) {}
            },
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
                  body: Stack(
                    children: [
                      Container(
                        height: 350.h,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: widget.store!.cover,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, __) =>
                                    Center(child: CircularProgressIndicator()),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.symmetric(vertical: 44.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 5.h),
                                      height: 36.h,
                                      width: 36.w,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/icons/arrow.svg",
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await widget.favoritesViewModel
                                          .add_remove_favorite_store(
                                              widget.store!);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 5.h),
                                      height: 36.h,
                                      width: 36.w,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: FittedBox(
                                        child: Icon(
                                          widget.favoritesViewModel
                                                  .checkIfFavoriteStore(
                                                      widget.store)
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: Color.fromRGBO(255, 171, 0, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 328.h,
                          ),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                topRight: Radius.circular(16.r),
                              ),
                            ),
                          )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 250.h),
                        child: SizedBox.expand(
                          child: Column(
                            children: [
                              InfoWidget(
                                store: widget.store,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          ratesViewModel.storeCupons == null
                                              ? Container(
                                                  width: 387.w,
                                                  height: 170.h,
                                                  child:
                                                      Center(child: Loading()))
                                              : ratesViewModel
                                                      .storeCupons!.isEmpty
                                                  ? NoDataWidget(
                                                      title:
                                                          "لاتوجد أي كوبونات لهذا المتجر ",
                                                    )
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10.h),
                                                      child: ListView.separated(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            ratesViewModel
                                                                .storeCupons!
                                                                .length,
                                                        separatorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return SizedBox(
                                                            height: 10.h,
                                                          );
                                                        },
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          DateTime cuponDate =
                                                              DateTime.parse(
                                                                  ratesViewModel
                                                                      .storeCupons![
                                                                          index]
                                                                      .expire);
                                                          return cuponDate
                                                                  .isBefore(
                                                                      DateTime
                                                                          .now())
                                                              ? SizedBox()
                                                              : Center(
                                                                  child:
                                                                      CodeWidget(
                                                                    cupon: ratesViewModel
                                                                            .storeCupons![
                                                                        index],
                                                                  ),
                                                                );
                                                        },
                                                      ),
                                                    ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: Divider(
                                              color:
                                                  Colors.grey.withOpacity(.5),
                                              height: 30.h,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              /*  GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isReviews = false;
                                              });
                                            },
                                            child: Text(
                                              "الفروع",
                                              style: GoogleFonts.tajawal(
                                                fontSize: 14.sp,
                                                color: isReviews
                                                    ? kDarkGreyColor
                                                    : kTextColor,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),*/
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isReviews = true;
                                                  });
                                                },
                                                child: Text(
                                                  "التقييمات",
                                                  style: GoogleFonts.tajawal(
                                                    fontSize: 14.sp,
                                                    color: !isReviews
                                                        ? kDarkGreyColor
                                                        : kTextColor,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 18.h,
                                          ),
                                          SizedBox(
                                            width: 383.h,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 2,
                                                  color: kGreyColor,
                                                ),
                                                /* Align(
                                              alignment: isReviews
                                                  ? Alignment.centerLeft
                                                  : Alignment.centerRight,
                                              child: Container(
                                                height: 2,
                                                color: kBlueColor,
                                                width: 150.w,
                                              ),
                                            ),*/
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          /*if (!isReviews)
                                        Column(
                                          children: [
                                            const LocalsWidget(),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            ListView.separated(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: 3,
                                              separatorBuilder:
                                                  (BuildContext context, int index) {
                                                return SizedBox(
                                                  height: 10.h,
                                                );
                                              },
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                return const Center(
                                                  child: LocationList(),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                          ],
                                        ),*/
                                          if (isReviews)
                                            Column(
                                              children: [
                                                ratesViewModel.ratedBefore
                                                    ? SizedBox()
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            _showBottomSheet(
                                                                context);
                                                          },
                                                          child: GradiantButton(
                                                              text:
                                                                  "قيم المتجر"),
                                                        ),
                                                      ),
                                                SizedBox(
                                                  height: 15.w,
                                                ),
                                                ratesViewModel.storeRates ==
                                                        null
                                                    ? Container(
                                                        width: 387.w,
                                                        height: 170.h,
                                                        child: Center(
                                                            child: Loading()))
                                                    : ratesViewModel
                                                            .storeRates!.isEmpty
                                                        ? NoDataWidget(
                                                            title:
                                                                "لاتوجد أي تقييمات لهذا المتجر ",
                                                          )
                                                        : Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        10.h),
                                                            child: ListView
                                                                .separated(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  ratesViewModel
                                                                      .storeRates!
                                                                      .length,
                                                              separatorBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return SizedBox(
                                                                  height: 10.h,
                                                                );
                                                              },
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return Center(
                                                                  child: ReviewWidget(
                                                                      rate: ratesViewModel
                                                                              .storeRates![
                                                                          index]),
                                                                );
                                                              },
                                                            ),
                                                          )
                                              ],
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
