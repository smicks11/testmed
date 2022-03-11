import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/routes/app_pages.dart';
import 'package:medfest/screens/app/home/controller/home_controller.dart';
import 'package:medfest/utils/colors.dart';

class UserSubscription extends StatefulWidget {
  const UserSubscription({Key? key}) : super(key: key);

  @override
  State<UserSubscription> createState() => _UserSubscriptionState();
}

class _UserSubscriptionState extends State<UserSubscription> {
  
  String paystackPublicKey = 'pk_test_dd6b39c260b850c9244e8f125d94c32b0bbd5c2f';
  late HomeController homeController;
  final plugin = PaystackPlugin();
  @override
  void initState() {
    homeController = Get.find<HomeController>();
    plugin.initialize(publicKey: paystackPublicKey);
    super.initState();
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'SubscriptionFromMEDFESTCARE${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  startVHSPayment(context) async {
    String refNo = _getReference();
    String amount = "70000";
    Charge charge = Charge()
      ..amount = int.parse(amount)
      ..reference = refNo
      ..plan = "PLN_871ytkftu1edi7f"
      //..accessCode = "hhdvjfbflf"
      ..email = homeController.walletInfo.value.email;

    CheckoutResponse response = await plugin.checkout(
      //CheckoutResponse response =
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if (response.status == true) {
      log(response.reference!);
      Navigator.pop(context, 'Successfully subscribed for VHS');
    }
  }

  startHSPayment(context) async {
    String refNo = _getReference();
    String amount = "35000";
    Charge charge = Charge()
      ..amount = int.parse(amount)
      ..reference = refNo
      ..plan = "PLN_0317yu38gcqov1k"
      //..accessCode = "hhdvjfbflf"
      ..email = homeController.walletInfo.value.email;

    CheckoutResponse response = await plugin.checkout(
      //CheckoutResponse response =
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if (response.status == true) {
      log(response.reference!);
      Navigator.pop(context, 'Successfully subscribed for HS');
    }
  }

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return SafeArea(
              child: Obx(
                () => Column(
                  children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         InkWell(
                           onTap: (){
                             Get.back();
                           },
                           child: Icon(Icons.clear,size:30)),
                         Expanded(
                           child: CText(
                             text: "Subscribe",
                             fontWeight: FontWeight.w400,
                             color: kBlackColor,
                             size: 20,
                           ),
                         ),
                       ],
                     ),
                    //  Align(
                    //   child: Icon(
                    //     icon: Icons.clear,
                    //   ),
                    // ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    const Align(
                      child: CText(
                        text:
                            "Get full access to all\n our amazing and healthy features",
                        fontWeight: FontWeight.w600,
                        color: kBlackColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    const Align(
                      child: CText(
                        text:
                            "Tip: You'll be given a VHS badge if you\n register as a Very Healthy Subscriber",
                        fontWeight: FontWeight.w400,
                        color: kTextFieldColor,
                        size: 14,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    features("Save money for health care"),
                    features("Locate medical facilities around you"),
                    features("Settle medical bills from your wallet"),
                    features("Access free health care when financially constrained."),
                    features("Transfer funds to friends and family for medical care."),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //const SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              //homeController.selectHSSub();
                              String refNo = _getReference();
                              String amount = "35000";
                              Charge charge = Charge()
                                ..amount = int.parse(amount)
                                ..reference = refNo
                                ..plan = "PLN_0317yu38gcqov1k"
                                //..accessCode = "hhdvjfbflf"
                                ..email = homeController.walletInfo.value.email;

                              CheckoutResponse response = await plugin.checkout(
                                //CheckoutResponse response =
                                context,
                                method: CheckoutMethod
                                    .card, // Defaults to CheckoutMethod.selectable
                                charge: charge,
                              );
                              if (response.status == true) {
                                log(response.reference!);
                                Navigator.pop(
                                    context, 'Successfully subscribed for HS');
                              }
                            },
                            child: Container(
                              height: constraints.maxHeight * 0.10,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(curveRadius),
                                border: Border.all(
                                    color: homeController.isHS.value == true
                                        ? kPrimaryColor
                                        : kTextFieldColor),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CText(
                                    text: "Healthy User",
                                    fontWeight: FontWeight.w600,
                                    color: kBlackColor,
                                    size: 20,
                                  ),
                                  SizedBox(height: 10),
                                  CText(
                                    text: "Monthly Access",
                                    fontWeight: FontWeight.w400,
                                    color: kTextFieldColor,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              //homeController.selectVHSSub();
                              String refNo = _getReference();
                              String amount = "70000";
                              Charge charge = Charge()
                                ..amount = int.parse(amount)
                                ..reference = refNo
                                ..plan = "PLN_871ytkftu1edi7f"
                                //..accessCode = "hhdvjfbflf"
                                ..email = homeController.walletInfo.value.email;

                              CheckoutResponse response = await plugin.checkout(
                                //CheckoutResponse response =
                                context,
                                method: CheckoutMethod
                                    .card, // Defaults to CheckoutMethod.selectable
                                charge: charge,
                              );
                              if (response.status == true) {
                                log(response.reference!);
                                Navigator.pop(
                                    context, 'Successfully subscribed for VHS');
                              }
                            },
                            child: Container(
                              height: constraints.maxHeight * 0.10,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(curveRadius),
                                border: Border.all(
                                    color: homeController.isVHS.value == true
                                        ? kPrimaryColor
                                        : kTextFieldColor),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CText(
                                    text: "Very Healthy User",
                                    fontWeight: FontWeight.w600,
                                    color: kBlackColor,
                                    size: 20,
                                  ),
                                  SizedBox(height: 10),
                                  CText(
                                    text: "Monthly Access",
                                    fontWeight: FontWeight.w400,
                                    color: kTextFieldColor,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: constraints.maxHeight * 0.10),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: CText(
                            text: "Done",
                            fontWeight: FontWeight.w400,
                            size: 18,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget features(
    String text,
  ) =>
      Row(
        children: [
          Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kPrimaryColor),
            ),
            child: const Center(
              child: Icon(
                Icons.done,
                color: kPrimaryColor,
              ),
            ),
          ),
          const SizedBox(width: 15),
          CText(
            text: text,
            color: kBlackColor,
            size: 12,
          ),
        ],
      );
}
