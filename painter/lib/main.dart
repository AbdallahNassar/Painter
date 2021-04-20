import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:painter/app/core/localization/languages.dart';

import 'app/routes/app_pages.dart';

void main() async {
  //Initialize local storage driver with await:
  var isStorageActive = await GetStorage.init();
  print(isStorageActive ? 'Storage is now Active' : 'Storage is disabled');
  runApp(Painter());
}

class Painter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Painter",
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      translations: Languages(),
      initialRoute: AppPages.HomeName,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
