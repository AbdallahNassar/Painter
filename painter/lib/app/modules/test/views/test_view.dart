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
            onPressed: controller.test,
          ),
        ],
      ),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.ac_unit),
          onPressed: controller.test,
        ),
      ),
    );
  }
}
