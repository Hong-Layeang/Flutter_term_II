import 'package:song/model/settings/app_settings.dart';

abstract class AppSettingsRepostitory {
  Future<AppSettings> load();
  Future<void> save(AppSettings settings);
}
