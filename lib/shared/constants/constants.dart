import '../../../../main.dart';
import '../localization/app_localization.dart';

String translate(String key) {
  return AppLocalizations.of(navigatorKey.currentContext!)?.translate(key) ??
      key;
}
