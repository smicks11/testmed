import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/services/api.dart';
import 'package:medfest/utils/enum.dart';

class MedicalController extends GetxController {
  TextEditingController requestAmountController = TextEditingController();
  TextEditingController walletController = TextEditingController();
  freeHealthCare(
      {required String walletAddress,
      required String type,
      required String amount}) async {
    //var response = await ApiService.postDataWithToken(data, url);
    try {
      log("freeHealthCare");
      var url = "usefreehealthcare/maternity/$walletAddress/$amount";
      var data = {};
      var response = await ApiService.postDataWithToken(data, url);
      if(response!=null){
        if(response.statusCode==200){
          log("Free healthcare used");
        }else{
          cToast(msg: response.body,color: Colors.red);
        }
      }else{
        cToast(msg: unable_to_connect,color: Colors.red);
      }
    } catch (e) {
      log(" ______------${e.toString()}");
      cToast(msg: unable_to_connect,color: Colors.red);
    }
  }
}
