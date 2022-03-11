import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/routes/app_pages.dart';
import 'package:medfest/screens/auth/signup/controller/signup_controller.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/colors.dart';

class IntroSubscription extends StatelessWidget {
  const IntroSubscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var signupController = Get.put(SignupController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return SafeArea(
              child: Obx(
                () => Column(
                  children: [
                    kLargeVerticalSpacing,
                    const Align(
                      child: CText(
                        text: "Subscribe",
                        fontWeight: FontWeight.w400,
                        color: kBlackColor, 
                        size: 20,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    const Align(
                      child: CText(
                        text: "Get full access to all\n our amazing and healthy features 🎉",
                        fontWeight: FontWeight.w600,
                        color: kBlackColor,
                        size: 20,
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
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              signupController.selectFreeSub();
                            },
                            child: Container(
                              height: constraints.maxHeight * 0.15,
                              decoration: BoxDecoration(
                                color: signupController.isFree.value == true ? kPrimaryColor : Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(curveRadius - 5),
                                border: Border.all(
                                    color: signupController.isFree.value == true
                                        ? kPrimaryColor
                                        : kTextFieldColor),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CText(
                                    text: "Free",
                                    fontWeight: FontWeight.w600,
                                    color: signupController.isFree.value == true ? Colors.white : kBlackColor,
                                    size: 20,
                                  ),
                                  SizedBox(height: 10),
                                  CText(
                                    text: "Limited Access",
                                    fontWeight: FontWeight.w400,
                                    color: kTextFieldColor,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              signupController.selectHSSub();
                            },
                            child: Container(
                              height: constraints.maxHeight * 0.15,
                              decoration: BoxDecoration(
                                color: signupController.isHS.value == true ? kPrimaryColor : Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(curveRadius - 5),
                                border: Border.all(
                                    color: signupController.isHS.value == true
                                        ? kPrimaryColor
                                        : kTextFieldColor),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                  CText(
                                    text: "Healthy User",
                                    fontWeight: FontWeight.w600,
                                    color: signupController.isHS.value == true ? Colors.white : kBlackColor,
                                    size: 18,
                                  ),
                                  SizedBox(height: 10),
                                  CText(
                                    text: "Monthly Access",
                                    fontWeight: FontWeight.w400,
                                    color: kTextFieldColor,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    kSmallVerticalSpacing,
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              signupController.selectVHSSub();
                            },
                            child: Container(
                              height: constraints.maxHeight * 0.15,
                              decoration: BoxDecoration(
                                color: signupController.isVHS.value == true ? kPrimaryColor : Colors.transparent,
                                borderRadius:
                                    BorderRadius.circular(curveRadius - 5),
                                border: Border.all(
                                    color: signupController.isVHS.value == true
                                        ? kPrimaryColor
                                        : kTextFieldColor),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                  CText(
                                    text: "Very Healthy User",
                                    fontWeight: FontWeight.w600,
                                    color: signupController.isVHS.value == true ? Colors.white : kBlackColor,
                                    size: 18,
                                  ),
                                  SizedBox(height: 10),
                                  CText(
                                    text: "Monthly Access",
                                    fontWeight: FontWeight.w400,
                                    color: kTextFieldColor,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // SizedBox(height: constraints.maxHeight * 0.15),
                    GestureDetector(
                      onTap: () {
                        signupController.isFree.value == true
                            ? Get.offNamed(Routes.MAIN_VIEW)
                            : null;
                      },
                      child: Container(
                        height: 70,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(curveRadius)),
                        child: Center(
                          child: CText(
                            text: signupController.isFree.value == true
                                ? "Go Free"
                                : "Subscribe",
                            fontWeight: FontWeight.w400,
                            size: 16,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                    ),
                    kSmallVerticalSpacing,
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget features(String text) => Row(
        children: [
          Container(
            height: 20,
            width: 20,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: kPrimaryColor),
            ),
            child: const Center(
              child: Icon(
                Icons.done,
                size: 12,
                color: Colors.white,
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
