import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  //================================ Properties ================================
  var _currentColor = Color(0xffffffff).obs;

  //================================ Constructor ===============================

  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SettingsView'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
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
                        pickerColor: _currentColor.value,
                        onColorChanged: (newColor) {
                          _currentColor.value = newColor;
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
        ),
      ),
    );
  }
}
