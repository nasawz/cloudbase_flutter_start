import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Obx(() => Text(controller.authState.value != null ? 'in' : 'out')),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => controller.loading.value
                ? CircularProgressIndicator()
                : SizedBox.shrink()),
            ElevatedButton(
              child: Obx(() => Text(
                  controller.authState.value != null ? 'logout' : 'login')),
              onPressed: () {
                if (!controller.loading.value) {
                  if (controller.authState.value != null) {
                    controller.logout();
                  } else {
                    controller.login();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
