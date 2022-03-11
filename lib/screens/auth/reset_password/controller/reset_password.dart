import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/API/api.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  RxString email = ''.obs;
  RxString otp = ''.obs;
  RxString error = ''.obs;
  RxString error1 = ''.obs;
  RxString error3 = ''.obs;
  RxString newPassword = ''.obs;

  RxBool loading = false.obs;

  requestResetPassword() async {
    loading.value = true;
    await API().getReq("requestotpforchangeofpassword/$email");
    cToast(msg: "OTP has been sent to your email address.",color: Colors.red);
    Get.toNamed(Routes.RESET_OTP);
  }
}
