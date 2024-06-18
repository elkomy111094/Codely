import 'package:smart_shoper_master/utiles/functions.dart';

import '../../../shared/generic_cubit/generic_cubit.dart';
import '../repositories/login_repo.dart';

class SplashViewModel {
  ///Constructor
  /// Called When Creating An Object From This View Moddel == initState
  SplashViewModel() {
    getSplashNextScreen();
  }

  GenericCubit<dynamic> splashCubit = GenericCubit(null);
  bool logoAppearance = false;
  LoginRepository loginRepository = LoginRepository();
}
