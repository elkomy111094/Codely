import 'package:flutter/material.dart';
import 'package:smart_shoper_master/models/store_model.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/models/failure.dart';
import '../models/category_model.dart';
import '../models/slider_model.dart';
import '../repositories/home_repository.dart';

class HomeViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  HomeViewModel() {
    if (slidersList == null) getHomeData();
    if (allStoresList == null) getAllStores();
  }

  GenericCubit<dynamic> homeCubit = GenericCubit(null);
  HomeRepository homeRepository = HomeRepository();
  List<SliderMModel>? slidersList;
  List<CategoryModel>? categoriesList;
  TextEditingController searchController = TextEditingController();
  List<StoreModel>? searchResualtList;
  List<StoreModel>? allStoresList;
  List<StoreModel>? moreChoicesStoresList;
  List<StoreModel>? recommendedStoresList;
  List<StoreModel>? unMissableStoresList;
  List<StoreModel>? bestOffersList;

  Future getHomeData() async {
    slidersList = homeCubit.onLoadingState();
    try {
      await homeRepository.getHome().then((value) {
        List slidersListJson = value["data"]["sliders"];
        List categoriesListJson = value["data"]["categories"];
        List offersListJson = value["offers"];
        List moreChoiceListJson = value["moreChoice"];
        List recommendListJson = value["recommend"];
        List unmissableListJson = value["unmissable"];

        slidersList =
            slidersListJson.map((e) => SliderMModel.fromJson(e)).toList();
        categoriesList =
            categoriesListJson.map((e) => CategoryModel.fromJson(e)).toList();
        bestOffersList =
            offersListJson.map((e) => StoreModel.fromJson(e)).toList();
        moreChoicesStoresList =
            moreChoiceListJson.map((e) => StoreModel.fromJson(e)).toList();
        recommendedStoresList =
            recommendListJson.map((e) => StoreModel.fromJson(e)).toList();
        unMissableStoresList =
            unmissableListJson.map((e) => StoreModel.fromJson(e)).toList();
        homeCubit.onSuccessRequest(null);
      });
    } on Failure catch (failure) {
      homeCubit.onErrorState(Failure(message: failure.message));
    }
  }

  //TODO:////////////////////////////////////////////////////////////////////////
  Future getHomeSliders() async {
    try {
      slidersList = await homeRepository.getSliders();
      homeCubit.onSuccessRequest(null);
    } on Failure catch (failure) {
      homeCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getHomeCategories() async {
    try {
      categoriesList = await homeRepository.getCategories();
      homeCubit.onSuccessRequest(null);
    } on Failure catch (failure) {
      homeCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getSearchedStores() async {
    if (searchResualtList != null) searchResualtList = null;
    homeCubit.onLoadingState();
    try {
      final data = {
        "name": searchController.text,
      };
      searchResualtList = await homeRepository.search(data: data);
      homeCubit.onSuccessRequest(searchResualtList);
    } on Failure catch (failure) {
      homeCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getAllStores() async {
    homeCubit.onLoadingState();
    try {
      allStoresList = await homeRepository.getStores(endPoint: "stores");
      homeCubit.onSuccessRequest(searchResualtList);
    } on Failure catch (failure) {
      homeCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getStoresMoreChoices() async {
    homeCubit.onLoadingState();
    try {
      moreChoicesStoresList =
          await homeRepository.getStores(endPoint: "stores/more_choice");
      homeCubit.onSuccessRequest(searchResualtList);
    } on Failure catch (failure) {
      homeCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getRecommendedStores() async {
    homeCubit.onLoadingState();
    try {
      recommendedStoresList =
          await homeRepository.getStores(endPoint: "stores/recommend");
      homeCubit.onSuccessRequest(searchResualtList);
    } on Failure catch (failure) {
      homeCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getUnmissableOffers() async {
    homeCubit.onLoadingState();
    try {
      unMissableStoresList =
          await homeRepository.getStores(endPoint: "stores/unmissable_offer");
      homeCubit.onSuccessRequest(searchResualtList);
    } on Failure catch (failure) {
      homeCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getBestOffers() async {
    homeCubit.onLoadingState();
    try {
      bestOffersList = await homeRepository.getStores(endPoint: "stores/offer");
      homeCubit.onSuccessRequest(searchResualtList);
    } on Failure catch (failure) {
      homeCubit.onErrorState(Failure(message: failure.message));
    }
  }
}
