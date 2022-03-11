import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';
import 'package:medfest/utils/colors.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({Key? key}) : super(key: key);

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
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: TextFormField(
                      initialValue: profileController.userData.value.email,
                      cursorColor: Colors.black.withOpacity(0.5),
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                        fontSize:16,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabled: false,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Obx(() => GestureDetector(
                      onTap: () {
                        profileController.verifyEmail();
                      },
                      child: Container(
                        height: 60,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: profileController.loading.value == true
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      kWhiteColor),
                                  strokeWidth: 1,
                                )
                              : CText(
                                  text: "Verify",
                                  letterSpacing: 0.5,
                                  // fontWeight: FontWeight.w600,
                                  size: 20,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
        Positioned(
          top: 55,
          left: 10,
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
                    size: 22,
                    letterSpacing: 1.0,
                    color: kWhiteColor,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: const CText(
                      text:
                          'Please confirm your email address and tap on verify to receive a verification link. Then follow the prompt from your email account',
                      fontWeight: FontWeight.w400,
                      size: 12,
                      letterSpacing: 0.5,
                      color: kWhiteColor,
                    ),
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
