import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/screens/app/home/controller/home_controller.dart';
import 'package:medfest/utils/colors.dart';
import 'package:medfest/utils/numeric_keyboard.dart';

class FundWallet extends StatefulWidget {
  const FundWallet({Key? key}) : super(key: key);

  @override
  _FundWalletState createState() => _FundWalletState();
}

class _FundWalletState extends State<FundWallet> {
  late HomeController homeController;
  String text = '';
  String paystackPublicKey = 'pk_test_dd6b39c260b850c9244e8f125d94c32b0bbd5c2f';
  final plugin = PaystackPlugin();
  @override
  void initState() {
    homeController = Get.find<HomeController>();
    plugin.initialize(publicKey: paystackPublicKey);
    super.initState();
  }

  startPayment(context) async {
    String refNo = _getReference();
    String amount = text + '00';
    Charge charge = Charge()
      ..amount = int.parse(amount)
      ..reference = refNo
      //..plan = ""
      //..accessCode = "hhdvjfbflf"
      ..email = homeController.walletInfo.value.email;
    // ..email = 'email@gmail.com';

    CheckoutResponse response = await plugin.checkout(
      //CheckoutResponse response =
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if (response.status == true) {
      log(response.reference!);
      await homeController.fundWallet(refNo: response.reference!);
      // setState(() {});
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFromMEDFESTCARE${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 590,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            color: kPrimaryColor),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: const CText(
                    text: "Fund Wallet",
                    color: kWhiteColor,
                    fontWeight: FontWeight.w600,
                    size: 16,
                    bold: true,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const CText(
                          text: "How much do you want to fund?",
                          color: Color(0xff4A4A4A),
                          fontWeight: FontWeight.w400,
                          size: 14,
                          bold: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          alignment: Alignment.centerLeft,
                          width: 221,
                          height: 48,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(35)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "₦ ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 19, color: kWhiteColor),
                                ),
                                Text(
                                  text == '' ? "0" : text,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView(
                            children: [
                              NumericKeyboard(
                                onKeyboardTap: (String val) {
                                  setState(() {
                                    text = text + val;
                                  });
                                },
                                textColor: const Color(0xff4A4A4A),
                                rightButtonFn: () {
                                  setState(() {
                                    text = text.substring(0, text.length - 1);
                                  });
                                },
                                rightIcon: const Icon(
                                  Icons.backspace,
                                  color: Color(0xff4A4A4A),
                                ),
                                leftButtonFn: () {
                                  // print('left button clicked');
                                },
                                leftIcon: const Icon(
                                  Icons.check,
                                  color: Color(0xff4A4A4A),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CupertinoButton(
                                padding: const EdgeInsets.all(5),
                                onPressed: text == ''
                                    ? null
                                    : () {
                                        log(text);
                                        Navigator.pop(context);
                                        startPayment(context);
                                      },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: text == ''
                                          ? kPrimaryColor.withOpacity(0.6)
                                          : kPrimaryColor,
                                      borderRadius: BorderRadius.circular(40)),
                                  height: 65,
                                  width: 327,
                                  child: const CText(
                                      text: "Continue",

                                      //fontFamily: 'AvenirNext-DemiBold',
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w600,
                                      size: 16,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
