import 'package:smart_shoper_master/models/store_model.dart';
import 'package:smart_shoper_master/repositories/categories_repo.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/models/failure.dart';

class CategoriesViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  HomeViewModel() {}

  GenericCubit<dynamic> categoriesCubit = GenericCubit(null);
  CategoriesRepository categoriesRepository = CategoriesRepository();

  List<StoreModel>? allCategoryStoresList;

  Future getAllCategoryStores(int catId) async {
    categoriesCubit.onLoadingState();
    try {
      allCategoryStoresList =
          await categoriesRepository.getStores(catId: catId);
      categoriesCubit.onSuccessRequest([]);
    } on Failure catch (failure) {
      categoriesCubit.onErrorState(Failure(message: failure.message));
    }
  }
}
