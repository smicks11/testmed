import 'package:get/get.dart';
import 'package:medfest/screens/app/map/controller/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MapController());
  }
}
