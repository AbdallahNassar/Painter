import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  //================================ Properties ================================
  final Widget child;
  final int flex;
  //================================ Constructor ===============================
  const SettingTile({
    required this.child,
    this.flex = 1,
  });
  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Card(
        elevation: 5.0,
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
