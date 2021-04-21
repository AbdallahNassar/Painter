import 'dart:convert';

import 'package:get/get.dart';

import 'package:painter/app/data/models/my_offset.dart';
import 'package:painter/app/data/models/painting.dart';

class TestController extends GetxController {
  //================================ Properties ================================
  var variable = 1.obs;
  void test() {
    try {
      print('=============================================');
      var x = <Painting>[Painting([]), Painting([], strokeWidth: 15)];
      var y = json.encode(x);
      var z = json.decode(
        y,
      );
      List<Painting> result =
          (z.map((element) => Painting.fromJson(element)).toList());

      print(result.runtimeType);
      // print(q);
      // var w = List.from(q);
      // print(w.runtimeType);
      // var x = Painting([]);
      // var y = json.encode(x);
      // print(y);
      // var z = json.decode(y);
      // print(z);
      // var q = Painting.fromJson(z);
      // print(q);
      print('=============================================');
    } catch (e) {
      print(e);
    }
  }
  //============================================================================
}

//  paint = Paint()
//       ..isAntiAlias = true
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.fill
//       ..strokeCap = StrokeCap.round
//       ..color = color;
//
