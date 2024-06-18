import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';
import 'package:smart_shoper_master/shared/util/app_routes.dart';
import 'package:smart_shoper_master/view_models/favorites_view_model.dart';

import '../../models/store_model.dart';
import '../util/ui.dart';
import 'rating_widget.dart';

class OfferWidget extends StatelessWidget {
  FavoritesViewModel favoritesViewModel;
  OfferWidget({
    Key? key,
    required this.favoritesViewModel,
    required this.isVerticle,
    required this.isCachBack,
    required this.store,
    this.cachBack,
  }) : super(key: key);
  final bool isVerticle;
  final bool isCachBack;
  final String? cachBack;
  StoreModel store;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: favoritesViewModel.favoritesCubit,
      listener: (context, state) {
        if (state is GenericErrorState) {
          UI.showAlert(
            context,
            message: state.responseError!.message,
            type: MessageType.error,
          );
        }
      },
      builder: (context, state) {
        return favoritesViewModel.favoritesList == null
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : Center(
                child: GestureDetector(
                  onTap: () {
                    UI.push(AppRoutes.offerDetailsScreen,
                        arguments: [store, favoritesViewModel]);
                  },
                  child: Container(
                    height: isCachBack ? 240.h : 210.h,
                    width: isVerticle ? 381.w : 312.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            spreadRadius: 2,
                            color: kGreyColor,
                          ),
                        ]),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                topRight: Radius.circular(16.r),
                              ),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: store!.cover,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, __) => Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 10.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RatingWidget(
                                            rating: store.rate.toString(),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Logger().d(store);
                                              favoritesViewModel
                                                  .add_remove_favorite_store(
                                                      store);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 5.h),
                                              height: 40.h,
                                              width: 40.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: FittedBox(
                                                child: Icon(
                                                  favoritesViewModel
                                                          .checkIfFavoriteStore(
                                                              store)
                                                      ? Icons.favorite
                                                      : Icons.favorite_outline,
                                                  color: Color.fromRGBO(
                                                      255, 171, 0, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      /*  const ReductionWidget(
                                        rate: '70',
                                      ),*/
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: isCachBack ? 83.h : 68.h,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor:
                                        kgreenColor.withOpacity(.3),
                                    backgroundImage: NetworkImage(store!.logo),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            store.desc,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: GoogleFonts.tajawal(
                                              fontSize: 16.sp,
                                              color: kTextColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (isCachBack)
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 40.w),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/cachback.svg",
                                        height: 20.h,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        "كاش باك " + cachBack!,
                                        overflow: TextOverflow.clip,
                                        style: GoogleFonts.tajawal(
                                          height: 2,
                                          fontSize: 12.sp,
                                          color: const Color.fromRGBO(
                                              255, 171, 0, 1),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
