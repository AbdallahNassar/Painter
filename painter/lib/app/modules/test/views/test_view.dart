import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestView'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: controller.add,
          ),
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: controller.edit,
          )
        ],
      ),
      body: Center(
        child: Obx(
          () => Text(
            controller.list.toString() +
                controller.list.last.value.memories.toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
