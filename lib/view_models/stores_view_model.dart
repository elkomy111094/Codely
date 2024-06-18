import 'package:flutter/material.dart';
import 'package:smart_shoper_master/models/store_model.dart';
import 'package:smart_shoper_master/repositories/stores_repo.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/models/failure.dart';
import '../models/category_model.dart';

class StoresViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  StoresViewModel() {
    if (categoriesList == null)
      getCategories();
    else {}
    if (recommendedStoresList == null)
      getRecommendedStores();
    else {}
    if (moreChoicesStoresList == null)
      getStoresMoreChoices();
    else {}
    if (allStoresList == null)
      getAllStores();
    else {}
  }

  GenericCubit<dynamic> storesCubit = GenericCubit(null);
  StoresRepository storesRepository = StoresRepository();

  List<CategoryModel>? categoriesList;
  TextEditingController searchController = TextEditingController();
  List<StoreModel>? searchResualtList;
  List<StoreModel>? allStoresList;
  List<StoreModel>? moreChoicesStoresList;
  List<StoreModel>? recommendedStoresList;

  Future getCategories() async {
    try {
      categoriesList = await storesRepository.getCategories();
      storesCubit.onSuccessRequest(null);
    } on Failure catch (failure) {
      storesCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getSearchedStores() async {
    if (searchResualtList != null) searchResualtList = null;
    storesCubit.onLoadingState();
    try {
      final data = {
        "name": searchController.text,
      };
      searchResualtList = await storesRepository.search(data: data);
      storesCubit.onSuccessRequest(searchResualtList);
    } on Failure catch (failure) {
      storesCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getAllStores() async {
    storesCubit.onLoadingState();
    try {
      allStoresList = await storesRepository.getStores(endPoint: "stores");
      storesCubit.onSuccessRequest(searchResualtList);
    } on Failure catch (failure) {
      storesCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getStoresMoreChoices() async {
    storesCubit.onLoadingState();
    try {
      moreChoicesStoresList =
          await storesRepository.getStores(endPoint: "stores/more_choice");
      storesCubit.onSuccessRequest(searchResualtList);
    } on Failure catch (failure) {
      storesCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getRecommendedStores() async {
    storesCubit.onLoadingState();
    try {
      recommendedStoresList =
          await storesRepository.getStores(endPoint: "stores/recommend");
      storesCubit.onSuccessRequest(searchResualtList);
    } on Failure catch (failure) {
      storesCubit.onErrorState(Failure(message: failure.message));
    }
  }
}
