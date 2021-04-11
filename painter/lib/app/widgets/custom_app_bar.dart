import 'package:flutter/material.dart';
import 'package:painter/app/core/theme/app_theme.dart';

// 'with' is like a mixin to allow this class to be of return type
// [StatelessWidget] and [PreferredSizeWidget]
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  //================================ Properties ================================
  final String text;
  //================================ Constructor ===============================
  const CustomAppBar({
    required this.text,
  });
  //================================= Methods ==================================
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  //============================================================================
}
