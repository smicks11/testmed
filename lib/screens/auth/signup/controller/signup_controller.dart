import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/routes/app_pages.dart';
import 'package:medfest/services/api.dart';
import 'package:medfest/services/storage.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController refferalcontroller = TextEditingController();

  late LocationData _currentPosition;
  Location location = Location();
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString confirmpassword = ''.obs;
  RxString referral_code = ''.obs;

  RxString error = ''.obs;
  RxString error1 = ''.obs;
  RxString error2 = ''.obs;
  RxString error3 = ''.obs;
  RxBool loading = false.obs;

  RxBool isFree = true.obs;
  RxBool isHS = false.obs;
  RxBool isVHS = false.obs;
  RxBool isOther = false.obs;

  selectFreeSub() {
    isFree.value = true;
    isHS.value = false;
    isVHS.value = false;
    isOther.value = false;
  }

  selectVHSSub() {
    isVHS.value = true;
    isHS.value = false;
    isFree.value = false;
    isOther.value = false;
  }

  selectHSSub() {
    isHS.value = true;
    isVHS.value = false;
    isFree.value = false;
    isOther.value = false;
  }

  selectOtherSub() {
    isOther.value = true;
    isFree.value = false;
    isHS.value = false;
    isVHS.value = false;
  }

  signup({required String accountType, required String? facilityType}) async {
    try {
      loading.value = true;
      log("${lat.value},${lng.value}");
      var data = {
        "email": email.value,
        "password": password.value,
        "full_name": name.value,
        "phone_no": "",
        "account_type": accountType,
        "org_type": facilityType == null ? "NULL" : facilityType,
        "referral_code": referral_code.value,
        "roles": accountType,
        "address": "${lat.value},${lng.value}"
      };
      var url = "register";
      final response = await ApiService.postData(data, url);
      log(response.toString());
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          log(data['token']);
          log('not empty');
          loading.value = false;
          await Storage.saveData("token", data['token']);
          await Storage.setStep("subscribe");
          Get.offAllNamed(Routes.INTRO_SUB);
        } else {
          loading.value = false;
        }
      } else {
        cToast(msg: response.body.toString(),color: Colors.red);
        loading.value = false;
      }
    } catch (e) {
      log(e.toString());
      loading.value = false;
      cToast(
          msg:
              "Unable to establish connection, check your internet connection",color: Colors.red);
    }
  }

  fetchLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    lat.value = _currentPosition.latitude!;
    lng.value = _currentPosition.longitude!;
    log('${lat.value}-----------------------------${lng.value}');
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   setState(() {
    //     _currentPosition = currentLocation;
    //     getAddress(_currentPosition.latitude, _currentPosition.longitude)
    //         .then((value) {
    //       setState(() {
    //         _address = "${value.first.addressLine}";
    //       });
    //     });
    //   });
    // });
  }

  @override
  void onReady() {
    fetchLocation();
    super.onReady();
  }
}
