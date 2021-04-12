import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:get/get.dart';
import 'package:painter/app/widgets/custom_app_bar.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'settings_view_title'.tr,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FlutterLogo(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomColorPalette extends StatelessWidget {
  final settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        'Colors',
      ),
      onPressed: () async {
        await Get.dialog(
          Material(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  ColorPicker(
                    pickerColor: settingsController.strokeColor,
                    onColorChanged: (newColor) {
                      settingsController.setColor = newColor;
                    },
                    showLabel: true,
                    displayThumbColor: true,
                    pickerAreaBorderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Got it',
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),
          useSafeArea: true,
          barrierDismissible: true,
        );
      },
    );
  }
}
