import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/widgets/simple_Header.dart';
import '../../../view_models/favorites_view_model.dart';
import '../../../view_models/home_view_model.dart';
import '../components/searched_store_list.dart';

class SearchResualtScreen extends StatefulWidget {
  HomeViewModel homeViewModel;
  FavoritesViewModel favoritesViewModel;
  SearchResualtScreen(
      {required this.homeViewModel, required this.favoritesViewModel});

  @override
  State<SearchResualtScreen> createState() => _SearchResualtScreenState();
}

class _SearchResualtScreenState extends State<SearchResualtScreen> {
  @override
  void initState() {
    widget.homeViewModel.getSearchedStores();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenericCubit, GenericCubitState>(
      bloc: widget.homeViewModel.homeCubit,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 120.h),
                      child: SearchStoresList(
                          homeViewModel: widget.homeViewModel,
                          favoritesViewModel: widget.favoritesViewModel),
                    ),
                    SimpleHeader(
                      headerTitle: widget.homeViewModel.searchController.text,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
