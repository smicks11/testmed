import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/models/user.dart';
import 'package:medfest/services/api.dart';
import 'package:medfest/utils/enum.dart';

class ProfileController extends GetxController {
  TextEditingController bvnController = TextEditingController();
  TextEditingController ninController = TextEditingController();
  RxString nin = ''.obs;
  RxString bvn = ''.obs;
  RxString error = ''.obs;
  RxBool loading = false.obs;
  Rx<UserData> userData = UserData(
    accessdate: DateTime.now(),
    accountType: '',
    badge: '',
    bvn: '',
    dateRegistered: DateTime.now(),
    email: '',
    emailVerification: '',
    fullName: '',
    fullyVerified: '',
    location: '',
    nin: '',
    phoneNo: '',
    point: 0,
    referralCode: '',
    subscriberStatus: '',
    tag: '',
    uid: '',
    walletAddress: '',
    address: '',
  ).obs;

  @override
  void onReady() {
    getUserProfileData();
    super.onReady();
  }

  getUserProfileData() async {
    try {
      var url = "profile";
      Map<String, dynamic> response = await ApiService.getDataWithToken(url);
      log(response.toString());
      log("getting user data ===================");
      if (response is! String) {
        userData.value = UserData.fromJson(response);
        log("gotten user info");
      } else {
        log("response is ${response.toString()}");
        cToast(msg: response.toString(),color: Colors.red);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  verifyEmail() async {
    try {
      loading.value = true;
      var url = "sendverification";
      var data = {};
      var response = await ApiService.postDataWithToken(data, url);
      if (response!=null) {
        if(response.statusCode==200){
          loading.value = false;
          cToast(msg: "Email verification link sent successfully",color: Colors.green);
          getUserProfileData();
          Get.back();
        }else{
          cToast(msg: response.body,color: Colors.red);
        }
       
      } else {
        log("response ");
        cToast(msg: unable_to_connect,color: Colors.red);
        Get.back();
        loading.value = false;
      }
    } catch (e) {
      log(e.toString());
      cToast(msg: unable_to_connect,color: Colors.red);
      Get.back();
      loading.value = false;
    }
  }

  verifyBVN() async {
    try {
      loading.value = true;
      var url = "updatebvn/${bvn.value}";
      var data = {};
      var response = await ApiService.postDataWithToken(data, url);
      if (response!=null) {
        if(response.statusCode==200){
          loading.value = false;
          cToast(msg: "BVN verification complete",color: Colors.green);
          getUserProfileData();
          Get.back();
        }else{
          cToast(msg: response.body,color: Colors.red);
        }
        
      } else {
        log("response ");
        cToast(msg: unable_to_connect,color: Colors.red);
        Get.back();
        loading.value = false;
      }
    } catch (e) {
      log(e.toString());
      cToast(msg: unable_to_connect,color: Colors.red);
      Get.back();
      loading.value = false;
    }
  }

  verifyNIN() async {
    try {
      loading.value = true;
      var url = "updatebvn/${bvn.value}";
      var data = {};
      var response = await ApiService.postDataWithToken(data, url);
      if (response!=null) {
        if(response.statusCode==200){
          loading.value = false;
          cToast(msg: "BVN verification complete",color: Colors.green);
          getUserProfileData();
          Get.back();
        }else{
          cToast(msg: response.body,color: Colors.red);
        }
        
      } else {
        cToast(msg: unable_to_connect,color: Colors.red);
        Get.back();
        loading.value = false;
      }
    } catch (e) {
      log(e.toString());
      cToast(msg: "Error! Please try again later",color: Colors.red);
      Get.back();
      loading.value = false;
    }
  }
}
