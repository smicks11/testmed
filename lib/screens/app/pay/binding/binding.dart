import 'package:get/get.dart';
import 'package:medfest/screens/app/pay/controller/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PaymentController());
  }
}
