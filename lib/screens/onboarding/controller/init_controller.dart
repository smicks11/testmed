import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:medfest/routes/app_pages.dart';
import 'package:medfest/services/storage.dart';

class InitController extends GetxController {
  navigate() async {
    String step = await Storage.getStep() ?? "no step";
    log(step);
    switch (step) {
      case "login":
        Timer(const Duration(seconds: 3), () {
          Get.offNamed(Routes.LOGIN);
        });
        break;
      case "subscribe":
        Timer(const Duration(seconds: 3), () {
          Get.offNamed(Routes.INTRO_SUB);
        });
        break;
      case "done":
        Timer(const Duration(seconds: 3), () {
          Get.offNamed(Routes.MAIN_VIEW);
        });
        break;
      default:
        Timer(
          const Duration(seconds: 3),
          () => Get.offNamed(Routes.ONBOARD_SCREEN),
        );
    }
  }

  @override
  void onReady() {
    navigate();
    super.onReady();
  }
}
