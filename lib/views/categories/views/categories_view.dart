import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_shoper_master/models/category_model.dart';
import 'package:smart_shoper_master/shared/constants/colors.dart';
import 'package:smart_shoper_master/shared/generic_cubit/generic_cubit.dart';
import 'package:smart_shoper_master/shared/widgets/simple_Header.dart';
import 'package:smart_shoper_master/view_models/categories_view_model.dart';
import 'package:smart_shoper_master/view_models/favorites_view_model.dart';

import '../../../shared/Common/loading_widget.dart';
import '../../../shared/Common/offer_widget.dart';
import '../../../shared/widgets/no_data_widget.dart';

class CategoriesView extends StatefulWidget {
  CategoriesView(
      {Key? key, required this.favoritesViewModel, required this.categoryModel})
      : super(key: key);
  FavoritesViewModel favoritesViewModel;
  final CategoryModel categoryModel;

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  CategoriesViewModel categoriesViewModel = CategoriesViewModel();
  @override
  void initState() {
    categoriesViewModel.getAllCategoryStores(widget.categoryModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: categoriesViewModel.categoriesCubit,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: kLightGreenColor,
            body: Column(
              children: [
                SimpleHeader(
                  headerTitle: widget.categoryModel.name,
                ),
                SizedBox(
                  height: 28.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor: kgreenColor.withOpacity(.3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.r),
                        child: Container(
                          height: 100.h,
                          width: 100.w,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: widget.categoryModel.image,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, __) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 28.h,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(43.r),
                        topRight: Radius.circular(43.r),
                      ),
                    ),
                    child: categoriesViewModel.allCategoryStoresList != null
                        ? categoriesViewModel.allCategoryStoresList!.isEmpty
                            ? Center(
                                child: Container(
                                    width: 300.w,
                                    height: 300.h,
                                    child: NoDataWidget(
                                        title: "لاتوجد عناصر في هذه الفئه")),
                              )
                            : SizedBox(
                                child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  scrollDirection: Axis.vertical,
                                  itemCount: categoriesViewModel
                                      .allCategoryStoresList!.length,
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
                                      store: categoriesViewModel
                                          .allCategoryStoresList![index],
                                    );
                                  },
                                ),
                              )
                        : Center(
                            child: Loading(),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
