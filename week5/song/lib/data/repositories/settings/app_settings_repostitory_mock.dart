import 'package:song/data/repositories/settings/app_settings_repostitory.dart';
import 'package:song/model/settings/app_settings.dart';

class AppSettingsRepostitoryMock implements AppSettingsRepostitory {
  AppSettings _settings = AppSettings(themeColor: ThemeColor.blue);

  @override
  Future<AppSettings> load() async {
    return _settings;
  }

  @override
  Future<void> save(AppSettings settings) async {
    _settings = settings;
  }
}
