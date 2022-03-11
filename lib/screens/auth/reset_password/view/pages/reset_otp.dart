import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/auth_textfield.dart';
import 'package:medfest/components/snack_bar.dart';

import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/routes/app_pages.dart';
import 'package:medfest/screens/auth/reset_password/controller/reset_password.dart';
import 'package:medfest/services/extension.dart';
import 'package:medfest/utils/colors.dart';
import 'package:medfest/utils/numeric_keyboard.dart';
import 'package:pinput/pin_put/pin_put.dart';

class CompleteResetEmail extends StatefulWidget {
  const CompleteResetEmail({Key? key}) : super(key: key);

  @override
  State<CompleteResetEmail> createState() => _CompleteResetEmailState();
}

class _CompleteResetEmailState extends State<CompleteResetEmail> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController textController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: kPrimaryColor.withOpacity(0.5),
      border: Border.all(color: const Color(0xFFF7F1FD)),
      borderRadius: BorderRadius.circular(curveRadius),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var resetPasswordController = Get.find<ResetPasswordController>();

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(22.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                SafeArea(
                  child: Container(
                    width: size.width,
                    color: kWhiteColor,
                    height: size.height * 0.90,
                    //padding: const EdgeInsets.all(18),
                    margin: EdgeInsets.only(top: constraints.maxHeight * 0.054),
                    child: Obx(
                      () => SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //SizedBox(height: size.height * 0.02),
                            const CText(
                              text: "Reset your",
                              fontWeight: FontWeight.w700,
                              size: 35,
                              color: kBlackColor,
                            ),
                            const SizedBox(height: 10),
                            const CText(
                              text: "Password",
                              fontWeight: FontWeight.w700,
                              size: 35,
                              color: kBlackColor,
                            ),
                            SizedBox(height: size.height * 0.08),
                            const CText(
                              text: "Your OTP*",
                              fontWeight: FontWeight.bold,
                              size: 16,
                              color: kBlackColor,
                            ),
                            const SizedBox(height: 10),
                            Container(
                              color: Colors.white,
                              // width: 260,
                              //height: 60,
                              margin: const EdgeInsets.all(5.0),
                              padding: const EdgeInsets.only(
                                left: 30.0,
                                right: 30,
                              ),
                              child: PinPut(
                                //obscureText: "●",
                                textStyle: const TextStyle(fontSize: 18),
                                separator: const SizedBox(width: 10),
                                mainAxisSize: MainAxisSize.max,
                                fieldsCount: 4,
                                eachFieldWidth: 60,
                                eachFieldHeight: 60,
                                onSubmit: (String pin) {
                                  // print(pin);
                                },
                                onChanged: (pin) {
                                  log(pin);
                                  if (pin.length == 4) {
                                    textController.text = pin;
                                    log(textController.text);
                                    setState(() {});
                                  }
                                },
                                focusNode: _pinPutFocusNode,
                                controller: textController,
                                submittedFieldDecoration:
                                    _pinPutDecoration.copyWith(
                                  borderRadius: BorderRadius.circular(23.0),
                                ),
                                selectedFieldDecoration: _pinPutDecoration,
                                followingFieldDecoration:
                                    _pinPutDecoration.copyWith(
                                  borderRadius: BorderRadius.circular(23.0),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.03),

                            const CText(
                              text: "Your Password*",
                              fontWeight: FontWeight.bold,
                              size: 16,
                              color: kBlackColor,
                            ),
                            const SizedBox(height: 10),
                            AuthTextField(
                              hint: "New Password",
                              prefixIcon: Icons.lock,
                              controller:
                                  resetPasswordController.newPasswordController,
                              inputType: TextInputType.visiblePassword,
                              error: resetPasswordController.error3.value,
                              validFunction: (v) => v!,
                              onSavedFunction: (s) => {
                                if (s.isValidPassword())
                                  {
                                    resetPasswordController.newPassword.value =
                                        s,
                                    resetPasswordController.error3.value = ''
                                    //print(email);
                                  }
                                else
                                  {
                                    resetPasswordController.newPassword.value =
                                        s,
                                    resetPasswordController.error3.value =
                                        "Password should contain at least 1 upper case, 1 lower case, 1 digit and at least 8 characters in length"
                                  }
                              },
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10),
                              child: CText(
                                text: resetPasswordController.error3.value,
                                size: 12,
                                fontWeight: FontWeight.w400,
                                color: kErrorColor,
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.08),

                            GestureDetector(
                              onTap: resetPasswordController
                                      .newPassword.value.isEmpty
                                  ? () {
                                      cToast(
                                          msg:
                                              "Please check your email and password is correct",
                                      color: Colors.red);
                                    }
                                  : () {
                                      // resetPasswordController
                                      //     .completeResetPassword(
                                      //         textController.text);
                                    },
                              child: Container(
                                height: 50,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius:
                                        BorderRadius.circular(curveRadius)),
                                child: Center(
                                  child:
                                      resetPasswordController.loading.value ==
                                              true
                                          ? const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      kWhiteColor),
                                              strokeWidth: 1,
                                            )
                                          : const CText(
                                              text: "Sign in",
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
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.SIGN_UP);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            CText(
                              text: "New User? ",
                              fontWeight: FontWeight.w500,
                              size: 16,
                              color: kSecondaryColor,
                            ),
                            CText(
                              text: "Create new account",
                              fontWeight: FontWeight.w500,
                              size: 16,
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
