import 'package:get/get.dart';
import 'package:medfest/screens/auth/signup/controller/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupController());
  }
}
