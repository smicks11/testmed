import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/services/api.dart';
import 'package:medfest/services/storage.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString error = ''.obs;
  RxString error1 = ''.obs;

  RxBool loading = false.obs;
  login() async {
    try {
      loading.value = true;
      var data = {
        "email": email.value,
        "password": password.value,
      };
      var url = "authenticate";
      final response = await ApiService.postData(data, url);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        //log(response.toString());
        if (data.isNotEmpty) {
          log(data['token']);
          log('not empty');
          loading.value = false;
          await Storage.saveData("token", data['token']);
          await Storage.setStep("done");
          Get.offAllNamed('/mainview');
        } else {
          loading.value = false;
        }
      } else if (response.statusCode == 403) {
        cToast(
            msg:
                "You registerd as an organization, please kindly wait while we verify your organization",color: Colors.red);
        loading.value = false;
      } else {
        cToast(msg: response.body.toString(),color: Colors.red);
        loading.value = false;
      }
    } catch (e) {
      //log(e.toString());
      cToast(
          msg:
              "Unable to establish connection, check your internet connection.",color: Colors.red);
      loading.value = false;
    }
  }
}
