import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  final box = GetStorage();

  _getCurrentLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      // Check if permission is granted
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
    // print(
    //     "===============${_locationData.latitude} : ${_locationData.longitude} ==========");
    latitude.value = _locationData.latitude!;
    longitude.value = _locationData.longitude!;
    box.write("lat", _locationData.latitude);
    box.write("lng", _locationData.longitude);
  }

  @override
  void onReady() {
    _getCurrentLocation();
    super.onReady();
  }
}
