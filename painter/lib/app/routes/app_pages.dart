import 'package:get/get.dart';

import 'package:painter/app/modules/home/bindings/home_binding.dart';
import 'package:painter/app/modules/home/views/home_view.dart';
import 'package:painter/app/modules/settings/bindings/settings_binding.dart';
import 'package:painter/app/modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  static const String HomeName = Routes.HOME;
  static const String SettingsName = Routes.SETTINGS;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
