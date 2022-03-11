import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medfest/components/auth_textfield.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/screens/app/home/controller/home_controller.dart';
import 'package:medfest/screens/app/pay/views/pages/enter_otp.dart';
import 'package:medfest/screens/app/pay/views/pages/scan_code.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/colors.dart';

class TransferFunds extends StatefulWidget {
  const TransferFunds({Key? key}) : super(key: key);

  @override
  State<TransferFunds> createState() => _TransferFundsState();
}

class _TransferFundsState extends State<TransferFunds> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var homeController = Get.find<HomeController>();
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                const SizedBox(height: 20),
                  Container(
                  child: Lottie.asset(
                    'assets/lottie/33810-payments.json',
                    height: 200.0,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CText(
                    text:
                        "Medfestcare helps you save money for personal and family's health care.\n\nSettle Family and friends medical bills from anywhere.",
                    fontWeight: FontWeight.normal,
                    size: 14,
                    color: Colors.black54,
                    textAlign: TextAlign.left,
                  ),
                ),
                kMediumVerticalSpacing,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CText(
                    text: "Enter friend/family's wallet address",
                    fontWeight: FontWeight.w400,
                    size: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: AuthTextField(
                        hint: "Wallet Address",
                        prefixIcon: Icons.lock,
                        controller: homeController.walletAddress,
                        inputType: TextInputType.visiblePassword,
                        error: homeController.error1.value,
                        validFunction: (v) => v!,
                        onSavedFunction: (s) => {
                          if (s.length > 10)
                            {
                              homeController.walletAddressString.value = s,
                              homeController.error1.value = ''
                              //print(email);
                            }
                          else
                            {
                              homeController.walletAddressString.value = s,
                              homeController.error1.value =
                                  "Enter Wallet Address to Proceed"
                            }
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var result = await Get.to(() => const ScanQR());
                        homeController.walletAddress.text = result ?? "No result";
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: kTextColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(curveRadius)),
                          child: const Center(
                              child: Icon(
                            Entypo.mobile,
                            color: kBlackColor,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                kLargeVerticalSpacing,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CText(
                    text: "Enter amount to transfer",
                    fontWeight: FontWeight.w400,
                    size: 14,
                  ),
                ),
                const SizedBox(height: 10),
                AuthTextField(
                  hint: "Amount",
                  prefixIcon: Icons.lock,
                  controller: homeController.amountController,
                  inputType: TextInputType.number,
                  error: homeController.errorAmount.value,
                  validFunction: (v) => v!,
                  onSavedFunction: (s) => {
                    if (s.isNotEmpty)
                      {
                        homeController.amountString.value = s,
                        homeController.errorAmount.value = ''
                        //print(email);
                      }
                    else
                      {
                        homeController.amountString.value = s,
                        homeController.errorAmount.value =
                            "Enter a valid amount to transfer"
                      }
                  },
                ),
                const Spacer(
                  flex: 1,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (homeController.walletAddress.text.trim().length > 10 &&
                          homeController.amountString.value.isNotEmpty&&homeController.amountString.toString()!="0") {
                        homeController.requestTransferOTP(
                            amount: homeController.amountString.value,
                            walletAddress:
                                homeController.walletAddressString.value);
                      } else {
                        null;
                      }
                    },
                    child: Container(
                      height: size.height*0.07,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: homeController.loading.value == true
                          ? const SpinKitChasingDots(
                        color: Colors.white,
                        size: 10,
                      )
                          : const Center(
                              child: CText(
                                text: "Proceed",
                                letterSpacing: 0.5,
                                // fontWeight: FontWeight.w600,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
