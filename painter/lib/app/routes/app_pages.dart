import 'package:get/get.dart';

import 'package:painter/app/modules/colorpicker/bindings/colorpicker_binding.dart';
import 'package:painter/app/modules/colorpicker/views/colorpicker_view.dart';
import 'package:painter/app/modules/home/bindings/home_binding.dart';
import 'package:painter/app/modules/home/views/home_view.dart';
import 'package:painter/app/modules/painting/bindings/painting_binding.dart';
import 'package:painter/app/modules/painting/views/painting_view.dart';
import 'package:painter/app/modules/settings/bindings/settings_binding.dart';
import 'package:painter/app/modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  static const String HomeName = Routes.HOME;
  static const String SettingsName = Routes.SETTINGS;
  static const String ColorPickerName = Routes.COLORPICKER;

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
    GetPage(
      name: _Paths.COLORPICKER,
      page: () => ColorpickerView(),
      binding: ColorpickerBinding(),
    ),
    GetPage(
      name: _Paths.PAINTING,
      page: () => PaintingView(),
      binding: PaintingBinding(),
    ),
  ];
}
