import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/core/theme/app_theme.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';
import 'package:painter/app/modules/home/widgets/springy_widget.dart';
import 'package:painter/app/modules/settings/views/settings_view.dart';

// 'with' is like a mixin to allow this class to be of return type
// [StatelessWidget] and [PreferredSizeWidget]
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  //================================ Properties ================================
  // I'm getting it like that and not through the constructor as this is
  // the main point of using 'Get' for dependency injection
  final homeController = Get.find<HomeController>();
  final String text;
  //================================ Constructor ===============================
  CustomAppBar({
    required this.text,
  });
  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: AppTheme.appTheme.appBarTheme.titleTextStyle,
      ),
      centerTitle: true,
      backgroundColor: AppTheme.appTheme.appBarTheme.backgroundColor,
      actionsIconTheme: AppTheme.appTheme.appBarTheme.actionsIconTheme,
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () async => await Get.to(
            () => SettingsView(),
            transition: Transition.cupertino,
            duration: Duration(milliseconds: 400),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  //============================================================================
}
