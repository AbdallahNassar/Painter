import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(Painter());
}

class Painter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Painter",
      initialRoute: AppPages.HomeName,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
