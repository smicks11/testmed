import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/models/transaction_history.dart';
import 'package:medfest/models/wallet.dart';
import 'package:medfest/screens/app/pay/views/pages/enter_otp.dart';
import 'package:medfest/services/api.dart';
import 'package:medfest/utils/enum.dart';

class HomeController extends GetxController {
  TextEditingController walletAddress = TextEditingController();
  TextEditingController amountController = TextEditingController();

  RxBool isAllSelected = true.obs;
  RxBool isAddedSelected = false.obs;
  RxBool isRemovedSelected = false.obs;
  RxInt index = 0.obs;
  RxInt billsIndex = 0.obs;
  RxString walletAddressString = "".obs;
  RxString amountString = "".obs;

  RxString error1 = "".obs;
  RxString errorAmount = "".obs;

  RxBool isPaySelected = true.obs;
  RxBool isTransferSelected = false.obs;
  RxBool isWithdrawSelected = false.obs;

  RxBool isHS = false.obs;
  RxBool isVHS = false.obs;

  RxString error = ''.obs;
  RxString error2 = ''.obs;

  RxBool loading = false.obs;

  RxString billsInfoText = "".obs;

  selectVHSSub() {
    isVHS.value = true;
    isHS.value = false;
  }

  selectHSSub() {
    isHS.value = true;
    isVHS.value = false;
  }

  showPayView() {
    billsIndex.value = 0;
    isPaySelected.value = true;
    isTransferSelected.value = false;
    isWithdrawSelected.value = false;
  }

  showTransferView() {
    billsIndex.value = 1;
    isTransferSelected.value = true;
    isWithdrawSelected.value = false;
    isPaySelected.value = false;
  }

  showWithdrawView() {
    billsIndex.value = 2;
    isWithdrawSelected.value = true;
    isTransferSelected.value = false;
    isPaySelected.value = false;
  }

  showAllTransaction() {
    index.value = 0;
    isAllSelected.value = true;
    isAddedSelected.value = false;
    isRemovedSelected.value = false;
  }

  showAddedTransaction() {
    index.value = 1;
    isAddedSelected.value = true;
    isAllSelected.value = false;
    isRemovedSelected.value = false;
  }

  showRemovedTransaction() {
    index.value = 2;
    isRemovedSelected.value = true;
    isAllSelected.value = false;
    isAddedSelected.value = false;
  }

  Rx<WalletInfo> walletInfo = WalletInfo(
          email: '',
          fullName: '',
          rateOfSpending: '',
          totalBalance: 0,
          uid: '',
          walletAddress: '')
      .obs;
  List<TransactionHistory> history = [];
  RxList<TransactionHistory> historyData = <TransactionHistory>[].obs;

  getWalletInfo() async {
    try {
      // log("getting wallet info");
      var url = "mywalletinfo";
      Map<String, dynamic> response = await ApiService.getDataWithToken(url);
      // log("wallet info ${response.toString()}");
      if (response is! String) {
        walletInfo.value = WalletInfo.fromJson(response);
        // log("gotten wallet info @ ${walletInfo.value.email} --${walletInfo.value.totalBalance}");
        return true;
      } else {
        cToast(msg: response.toString(), color: Colors.red);
        return true;
      }
    } catch (e) {
      log(e.toString());
      return true;
    }
  }

  getTransactionHistory() async {
    try {
      // log("getting transaction history");
      var url = "gettransactionhistory";
      var response = await ApiService.getDataWithTokenTwo(url);
      if (response is! String) {
        history = transactionHistoryFromJson(response);
        historyData.value = history;
      } else {
        if (response.isNotEmpty) {
          history = transactionHistoryFromJson(response);
          historyData.value = history;
          // log(historyData.value.first.last4);
          return true;
        }
        // cToast(msg: response.toString());
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  fundWallet({required String refNo}) async {
      log("funding wallet");
      var url = "fundmywallet/$refNo/${walletInfo.value.walletAddress}";
      var data = {};
      var response = await ApiService.postDataWithToken(data, url);
      if(response!=null){
        if(response.statusCode==200){
            log("funded wallet");
            cToast(msg: "You have successfully funded your wallet",color: Colors.green);
            // await getTransactionHistory();
            // await getWalletInfo();
            // await getTransactionHistory();
            // await getWalletInfo();
            return true;
        }else{
          cToast(msg: response.body,color: Colors.red);
        }
      }else{
        cToast(msg: unable_to_connect,color: Colors.red);
      }
  }

  refreshData() {
    getTransactionHistory();
    getWalletInfo();
  }

  requestTransferOTP(
      {required String amount, required String walletAddress}) async {
      loading.value = true;
      var url = "sendtransactionotp/$amount/$walletAddress";
      final response = await ApiService.postDataWithToken({},url);
      if(response!=null){
        if (response.statusCode == 200) {
            loading.value = false;
            cToast(msg: "OTP has been sent to your email address",color: Colors.green);
            Get.to(() => const EnterOTP());
        } else if (response.statusCode == 403) {
          cToast(msg: "Unable to perform transaction. Access denied",color: Colors.red);
          loading.value = false;
        }
      } else {
        cToast(msg: "Unable to establish connection",color: Colors.red);
        loading.value = false;
      }
  }

  completeTransfer({required String otp}) async {
      loading.value = true;
      var data = {};
      var url =
          "transferfunds/${walletAddressString.value}/${amountString.value}/$otp";
      final response = await ApiService.postDataToken(data, url);
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        //log(response.toString());
        if (data.isNotEmpty) {
          // log(data.toString());

          // log('not empty');
          loading.value = false;
          Get.back();
          Get.back();

          cToast(msg: "Transaction successfully completed",color: Colors.green);
        } else {
          loading.value = false;
        }
      } else if (response.statusCode == 403) {
        cToast(msg: "Unable to perform transaction. Please try again",color: Colors.red);
        loading.value = false;
      }
  }

  @override
  void onReady() {
    getWalletInfo();
    getTransactionHistory();
    super.onReady();
  }
}
