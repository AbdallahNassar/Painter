import 'package:flutter/material.dart';
import 'package:painter/app/core/theme/app_colors.dart';
import 'package:painter/app/core/theme/app_theme.dart';

class CustomSlider extends StatelessWidget {
  //================================ Properties ================================
  final String text;
  final double value;
  final double maxValue;
  final double minValue;
  final Function onChanged;
  //================================ Constructor ===============================
  const CustomSlider({
    required this.text,
    required this.value,
    required this.onChanged,
    required this.maxValue,
    required this.minValue,
  });
  //================================= Methods ==================================

  //============================================================================
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: AppTheme.appTheme.textTheme.subtitle1,
          ),
        ),
        Slider.adaptive(
          value: value,
          onChanged: (newSize) => onChanged(newSize),
          max: maxValue,
          min: minValue,
          activeColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}
