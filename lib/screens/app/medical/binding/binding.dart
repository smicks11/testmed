import 'package:get/get.dart';
import 'package:medfest/screens/app/medical/controller/medical_controller.dart';

class MedicalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MedicalController());
  }
}
