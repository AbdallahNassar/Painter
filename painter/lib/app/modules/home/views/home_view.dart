import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:painter/app/modules/home/widgets/custom_fab.dart';
import 'package:painter/app/modules/home/widgets/home_body.dart';
import 'package:painter/app/modules/home/widgets/scaling_widget.dart';

import 'package:painter/app/modules/settings/controllers/settings_controller.dart';
import 'package:painter/app/modules/settings/views/settings_view.dart';
import 'package:painter/app/widgets/custom_app_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  //================================ Parameters ===============================
  final _settingsController = Get.find<SettingsController>();
  //==========================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    controller.setSettingsController = (_settingsController);
    //==========================================================================
    return Scaffold(
      appBar: CustomAppBar(
        text: 'home_view_title'.tr,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async => await Get.to(
              () => SettingsView(),
              transition: Transition.cupertino,
              duration: Duration(milliseconds: 400),
              popGesture: true,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.save_outlined,
            ),
            onPressed: controller.save,
          ),
        ],
      ),
      body: ScalingWidget(
        child: HomeBody(),
        height: 200,
        width: 300,
      ),
      floatingActionButton: Container(
        child: CustomFAB(),
        height: 50.0,
      ),
    );
  }
}

//  SizedBox(
//         height: 300,
//         width: 300,
//         child: Container(
//           child: FittedBox(
//             fit: BoxFit.contain,
//             alignment: Alignment.center,
//             child: SizedBox(
//               height: 500,
//               width: 500,
//               child: HomeBody(),
//             ),
//           ),
//         ),
//       ),
