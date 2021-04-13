import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  //================================ Properties ================================
  final Widget child;
  //================================ Constructor ===============================
  const SettingTile({required this.child});
  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    //================================ Parameters ==============================
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    //==========================================================================
    return Expanded(
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: child,
      ),
    );
  }
}
