import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/medical/controller/medical_controller.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';
import 'package:medfest/utils/colors.dart';

class FreeHealthCareDialog extends StatelessWidget {
  final String assetName;
  final String title;
  final double availablebalance;

  const FreeHealthCareDialog(
      {Key? key,
      required this.assetName,
      required this.title,
      required this.availablebalance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var medicalController = Get.find<MedicalController>();
    var profileController = Get.find<ProfileController>();
    double HEIGTH=MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const CText(
        text: "Use your free healthcare",
        size: 20,
        fontWeight: FontWeight.w500,
        color: kPrimaryColor,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CText(
              text:
                  "Note: Amount provided will be deducted from your free health care balance",
              size: 12,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
            Image.asset(
              assetName,
              height: HEIGTH*0.1,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: medicalController.requestAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Amount ",
                  hintStyle: TextStyle(
                    fontSize: 12
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kDarkGreyColor, width: 2)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kDarkGreyColor, width: 2))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: medicalController.walletController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  hintText: "Enter recipient wallet address",
                  hintStyle: TextStyle(
                    fontSize: 12
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kDarkGreyColor, width: 2)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kDarkGreyColor, width: 2))),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if (medicalController.requestAmountController.text
                    .trim().isNotEmpty && medicalController.walletController.text.trim().isNotEmpty) {
                  if(double.parse(medicalController.requestAmountController.text.trim())<=availablebalance){
                    medicalController.freeHealthCare(
                        walletAddress:
                        profileController.userData.value.walletAddress,
                        type: title,
                        amount: medicalController.requestAmountController.text
                            .trim());
                    Get.back();
                  }else{
                    cToast(
                      msg:
                      "You can't use more than available balance",color: Colors.red);
                  }
                 
                } 
                
              },
              child: Container(
                height: HEIGTH*0.05,
                width: size.width,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: CText(
                    text: "Proceed",
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                    size: 12,
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
