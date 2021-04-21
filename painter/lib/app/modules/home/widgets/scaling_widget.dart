import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScalingWidget extends StatelessWidget {
  //================================ Properties ================================
  final double height;
  final double width;
  final Widget child;
  //================================ Constructor ===============================
  const ScalingWidget({
    required this.height,
    required this.width,
    required this.child,
  });
  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            height: Get.height,
            width: Get.width * 1.1,
            child: child,
          ),
        ),
      ),
    );
  }
}
