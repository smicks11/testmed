import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';
import 'package:medfest/utils/colors.dart';
import 'package:medfest/services/extension.dart';

class VerifyNIN extends StatelessWidget {
  const VerifyNIN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            color: kPrimaryColor,
          ),
        ),
        Container(
          height: size.height,
          width: size.width,
          margin: EdgeInsets.only(top: size.height * 0.25),
          padding: const EdgeInsets.all(18),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(curveRadius),
              topRight: Radius.circular(curveRadius),
            ),
            color: kWhiteColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Obx(
              () => Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: TextFormField(
                        controller: profileController.ninController,
                        cursorColor: Colors.black.withOpacity(0.5),
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.7),
                        ),
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintText: "Enter NIN",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabled: true,
                        ),
                        onChanged: (s) {
                          if (s.isNumeric()) {
                            profileController.nin.value = s;
                            profileController.error.value = '';
                          } else {
                            profileController.error.value = "NIN not valid";
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.all(10),
                    child: CText(
                      text: profileController.error.value,
                      size: 15,
                      fontWeight: FontWeight.w400,
                      color: kErrorColor,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: profileController.nin.value == '' ? () {
                            cToast(msg: "Please enter BVN",color: Colors.red);
                          } : () {},
                    child: Container(
                      height: 60,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: CText(
                          text: "Verify",
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w600,
                          size: 20,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 20,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kWhiteColor,
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.08),
              child: Column(
                children: [
                  const CText(
                    text: 'Personal Information',
                    fontWeight: FontWeight.w600,
                    size: 26,
                    letterSpacing: 1.0,
                    color: kWhiteColor,
                  ),
                  SizedBox(height: size.height * 0.03),
                  const CText(
                    text:
                        'Please confirm your NIN and your click verify to receive a verification link. Then follow the prompt from your email account',
                    fontWeight: FontWeight.w400,
                    size: 15,
                    letterSpacing: 1.0,
                    color: kWhiteColor,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
