import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/services/api.dart';
import 'package:medfest/utils/enum.dart';

class PaymentController extends GetxController {
  TextEditingController donateController = TextEditingController();
  List<String> banks = [
    'Access Bank Plc',
    'Fidelity Bank Plc',
    'First City Monument Bank Limited',
    'First Bank of Nigeria Limited',
    'Guaranty Trust Holding Company Plc',
    'Union Bank of Nigeria Plc',
    'United Bank for Africa Plc',
    'Zenith Bank Plc',
  ]; // Option 2
  RxString selectedBank = 'Access Bank Plc'.obs;

  withdraw(
      {required String selectedBank,
      required String amount,
      required String accountNumber}) async {
      log("withdraw request");
      var url = "requestfunds";
      var data = {
        "amount": amount,
        "bank_name": selectedBank,
        "account_no": accountNumber
      };
      var response = await ApiService.postDataWithToken(data, url);
      if (response!=null){
        if(response.statusCode==200){
          log("funded wallet");
          cToast(msg: "You have successfully requsted for a withdrawal ",color: Colors.green);
        }else{
          cToast(msg: response.body,color: Colors.red);
        }
      } else {
        // log("donate request response is ${response['error']}");
        cToast(msg: unable_to_connect,color: Colors.red);
      }
  }

  donate({
    required String amount,
  }) async {
      log("Donate request");
      var url = "donate/$amount";
      var data = {
        "amount": amount,
      };
      final response = await ApiService.postDataWithToken(data, url);
      //log(response.toString());
      if(response!=null){
        if (response.statusCode==200) {
          //log("Donated from wallet");
          cToast(msg: "You have successfully Donated to MEDFESTCARE, your funds will be used to take care of the needy ",color: Colors.green);
        } else {
          // log("donate request response is ${response['error']}");
          cToast(msg: response.body,color: Colors.red);
        }
      }else{
        cToast(msg: unable_to_connect,color: Colors.red);
      }
  }
}
