import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_shoper_master/view_models/favorites_view_model.dart';

import '../../../shared/Common/loading_widget.dart';
import '../../../shared/Common/offer_widget.dart';
import '../../../shared/widgets/no_data_widget.dart';
import '../../../view_models/home_view_model.dart';

class SearchStoresList extends StatelessWidget {
  SearchStoresList({
    super.key,
    required this.homeViewModel,
    required this.favoritesViewModel,
  });

  final HomeViewModel homeViewModel;
  final FavoritesViewModel favoritesViewModel;

  @override
  Widget build(BuildContext context) {
    return homeViewModel.searchResualtList == null
        ? Center(child: Loading())
        : homeViewModel.searchResualtList!.isEmpty
            ? Center(
                child: NoDataWidget(
                    title: "لم يتم العصور علي أي متاجر بهذا الاسم"))
            : ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                itemBuilder: (context, index) {
                  return OfferWidget(
                    isVerticle: false,
                    isCachBack: false,
                    favoritesViewModel: favoritesViewModel,
                    store: homeViewModel.searchResualtList![index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
                itemCount: homeViewModel.searchResualtList!.length);
  }
}
