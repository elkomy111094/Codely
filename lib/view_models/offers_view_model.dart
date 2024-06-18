import 'package:smart_shoper_master/models/store_model.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/models/failure.dart';
import '../repositories/offers_repository.dart';

class OffersViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  OffersViewModel() {
    if (bestOffersList == null) getBestOffers();
    if (allStoresList == null) getAllStores();
  }

  GenericCubit<dynamic> offersCubit = GenericCubit(null);
  OffersRepository offersRepository = OffersRepository();

  List<StoreModel>? allStoresList;
  List<StoreModel>? bestOffersList;

  Future getAllStores() async {
    offersCubit.onLoadingState();
    try {
      allStoresList = await offersRepository.getStores(endPoint: "stores");
      offersCubit.onSuccessRequest(null);
    } on Failure catch (failure) {
      offersCubit.onErrorState(Failure(message: failure.message));
    }
  }

  Future getBestOffers() async {
    offersCubit.onLoadingState();
    try {
      bestOffersList =
          await offersRepository.getStores(endPoint: "stores/offer");
      offersCubit.onSuccessRequest(null);
    } on Failure catch (failure) {
      offersCubit.onErrorState(Failure(message: failure.message));
    }
  }
}
