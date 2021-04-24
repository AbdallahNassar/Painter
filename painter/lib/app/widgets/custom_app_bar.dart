import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/app/core/theme/app_theme.dart';
import 'package:painter/app/modules/home/controllers/home_controller.dart';

// 'with' is like a mixin to allow this class to be of return type
// [StatelessWidget] and [PreferredSizeWidget]
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  //================================ Properties ================================
  // I'm getting it like that and not through the constructor as this is
  // the main point of using 'Get' for dependency injection
  final homeController = Get.find<HomeController>();
  final String text;
  final bool haveBackArrow;
  final Color backgroundColor;
  final double elevation;
  final List<Widget> actions;
  final Widget? leading;
  //================================ Constructor ===============================
  CustomAppBar({
    this.text = ' ',
    this.leading,
    this.haveBackArrow = true,
    this.backgroundColor = Colors.blue,
    this.elevation = 4.0,
    this.actions = const <Widget>[],
  });
  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
        ),
      ),
      leading: leading,
      centerTitle: true,
      backgroundColor: backgroundColor,
      actionsIconTheme: AppTheme.appTheme.appBarTheme.actionsIconTheme,
      iconTheme: AppTheme.appTheme.appBarTheme.iconTheme,
      actions: actions,
      elevation: elevation,
      automaticallyImplyLeading: haveBackArrow,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  //============================================================================
}
