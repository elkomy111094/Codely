import 'package:smart_shoper_master/models/settings_data_model.dart';
import 'package:smart_shoper_master/repositories/settings_repo.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../../../shared/models/failure.dart';

class SettingsViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  SettingsViewModel() {
    getSettingsData();
  }

  GenericCubit<dynamic> settingsCubit = GenericCubit(null);
  SettingsRepository settingsRepository = SettingsRepository();
  SettingsData? settingsData;

  Future getSettingsData() async {
    try {
      settingsData = await settingsRepository.getAppSettings();
      settingsCubit.onSuccessRequest(null);
    } on Failure catch (failure) {
      settingsCubit.onErrorState(Failure(message: failure.message));
    }
  }
}
