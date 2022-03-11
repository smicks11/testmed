import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/home/controller/home_controller.dart';
import 'package:medfest/screens/app/pay/controller/payment_controller.dart';
import 'package:medfest/services/extension.dart';
import 'package:medfest/utils/colors.dart';

class DonateDialog extends StatelessWidget {
  const DonateDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var paymentController = Get.find<PaymentController>();
    var homeController = Get.find<HomeController>();
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const CText(
        text: "Donate",
        size: 20,
        fontWeight: FontWeight.bold,
        color: kPrimaryColor,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              donate,
              height: size.height*0.3,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: paymentController.donateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Enter amount to donate",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 2)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kDarkGreyColor, width: 2))),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                if (paymentController.donateController.text.trim().isNumeric()&&paymentController.donateController.text.toString().trim()!="0") {
                  paymentController.donate(amount: paymentController.donateController.text);
                  homeController.refreshData();
                  paymentController.donateController.clear();
                  Get.back();
                  // Get.to(() => EnterOTP());
                } else {
                  cToast(msg: "Input character incorrect",color: Colors.red);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                height: size.height*0.05,
                width: size.width,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                  child: CText(
                    text: "Proceed",
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
