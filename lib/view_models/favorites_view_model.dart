import 'package:smart_shoper_master/models/store_model.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/models/failure.dart';
import '../repositories/favorites_repo.dart';

class FavoritesViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  FavoritesViewModel() {
    getFavoritesStores();
  }

  GenericCubit<dynamic> favoritesCubit = GenericCubit(null);
  FavoritesRepository favoritesRepository = FavoritesRepository();
  List<StoreModel>? favoritesList;

  bool checkIfFavoriteStore(store) {
    bool exist = false;

    if (favoritesList == null) {
      print(
          "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      return false;
    } else {
      favoritesList!.forEach((element) {
        if (element.id == store.id) {
          exist = true;
        }
      });
      if (exist) {
        return true;
      } else {
        return false;
      }
    }
  }
  /* bool checkIfFavoriteStore(store) {
    if (favoritesList == null) {
      return false;
    } else {
      if (favoritesList!.isEmpty) {
        return false;
      } else {
        if (favoritesList!.contains(store)) {
          return true;
        } else {
          return false;
        }
      }
    }
  }*/

  Future add_remove_favorite_store(StoreModel store) async {
    if (favoritesList == null) {
      print(
          "ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
      return;
    } else {
      if (favoritesList!.contains(store)) {
        print("I am 2");
        favoritesList!.removeWhere((element) => element.id == store.id);
        favoritesCubit.onUpdateData(null);
        await deleteFromFavorites(store.id);
        return;
      } else {
        print("I am 3");
        favoritesList!.add(store);
        favoritesCubit.onUpdateData(null);
        await addStoreToFavorites(store.id);
      }
    }
  }

  Future getFavoritesStores() async {
    try {
      await favoritesRepository.getFavoritesList().then((value) {
        favoritesList = value;
      });
      favoritesCubit.onSuccessRequest(null);
    } on Failure catch (failure) {
      favoritesCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future addStoreToFavorites(int id) async {
    try {
      await favoritesRepository.addToFavorites(id: id);
    } on Failure catch (failure) {
      favoritesCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future deleteFromFavorites(int id) async {
    try {
      await favoritesRepository.deleteFromFavorites(id: id);
    } on Failure catch (failure) {
      favoritesCubit.onErrorState(Failure(message: failure.message));
    }
  }
}
