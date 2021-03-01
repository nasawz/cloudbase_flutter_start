import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    print('++++');
    print(controller.authState.value);
    print('++++');

    return Scaffold(
      appBar: AppBar(
        title:
            Obx(() => Text(controller.authState.value != null ? 'in' : 'out')),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text("login"),
              onPressed: () {
                if (controller.authState.value != null) {
                  controller.logout();
                } else {
                  controller.login();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
