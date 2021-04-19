import 'package:get/get.dart';

class TestController extends GetxController {
  //================================ Properties ================================
  var list = [
    Human(memories: [1, 3]).obs
  ].obs;
  //================================ Constructor ===============================

  //================================= Methods ==================================
  void add() {
    list.add(Human(memories: [1, 2]).obs);
  }

  void remove() {
    list.removeLast();
  }

  void edit() {
    list.last.value.memories.add(13);
    print(list.last.value.memories);
  }
  //============================================================================

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}

class Human {
  final String name;
  final List<int> memories;
  num age;
  Human({
    this.age = 24,
    this.name = 'Nassar',
    required this.memories,
  });
}
//============================================================================
