import 'package:get/get.dart';
import 'package:medfest/screens/auth/reset_password/controller/reset_password.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResetPasswordController());
  }
}
