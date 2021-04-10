// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// class CustomColorPicker extends StatelessWidget {
//   //================================ Properties ================================
//   static const String routeName = '/names';
//   //================================ Constructor ===============================

//   //================================= Methods ==================================

//   //============================================================================
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             SizedBox(
//               height: 50.0,
//             ),
//             ColorPicker(
//               pickerColor: _currentColor.value,
//               onColorChanged: (newColor) {
//                 _currentColor.value = newColor;
//               },
//               showLabel: true,
//               displayThumbColor: true,
//               pickerAreaBorderRadius: BorderRadius.circular(
//                 20.0,
//               ),
//             ),
//             TextButton(
//               onPressed: () => Get.back(),
//               child: Text(
//                 'Got it',
//               ),
//             ),
//             SizedBox(
//               height: 50.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
