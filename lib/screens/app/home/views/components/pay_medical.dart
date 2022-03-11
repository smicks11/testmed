import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medfest/components/auth_textfield.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/screens/app/home/controller/home_controller.dart';
import 'package:medfest/screens/app/pay/views/pages/scan_code.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/colors.dart';

class PayMedicalFees extends StatefulWidget {
  const PayMedicalFees({Key? key}) : super(key: key);

  @override
  State<PayMedicalFees> createState() => _PayMedicalFeesState();
}

class _PayMedicalFeesState extends State<PayMedicalFees> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var homeController = Get.find<HomeController>();
    return SizedBox(
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
                    height: 100.0,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CText(
                    text:
                        "Settle hospital/Lab bills from your MEDFESTCARE Wallet.\n\nPay for medications procured at our registered pharmacies from your MEDFESTCARE Wallet.",
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
                  text: "Enter health facility\'s wallet address",
                  fontWeight: FontWeight.w400,
                  size: 12,
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
                      padding: const EdgeInsets.all(3.0),
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
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: CText(
                  text: "Enter amount to transfer",
                  fontWeight: FontWeight.w400,
                  size: 12,
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
                      homeController.errorAmount.value =
                          "Enter an amount to transfer"
                    }
                },
              ),
              const Spacer(),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    if (homeController.walletAddress.text.trim().length > 10 &&
                        homeController.amountString.value.isNotEmpty) {
                      homeController.requestTransferOTP(
                          amount: homeController.amountString.value,
                          walletAddress:
                              homeController.walletAddressString.value);
                    } else {
                      null;
                    }
                  },
                  child: Container(
                    height: 60,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: homeController.loading.value == true
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kWhiteColor),
                            strokeWidth: 1,
                          )
                        : Center(
                            child: CText(
                              text: "Proceed",
                              letterSpacing: 0.5,
                              // fontWeight: FontWeight.w600,
                              size: 16,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                  ),
                ),
              ),
              kLargeVerticalSpacing,
            ],
          );
        },
      ),
    );
  }
}
