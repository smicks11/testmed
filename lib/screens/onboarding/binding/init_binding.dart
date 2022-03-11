import 'package:get/get.dart';
import 'package:medfest/screens/onboarding/controller/init_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InitController());
  }
}
