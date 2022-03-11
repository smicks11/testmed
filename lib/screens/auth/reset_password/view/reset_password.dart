import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/auth_textfield.dart';
import 'package:medfest/components/snack_bar.dart';

import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/routes/app_pages.dart';
import 'package:medfest/screens/auth/reset_password/controller/reset_password.dart';
import 'package:medfest/services/extension.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/app_textstyle.dart';
import 'package:medfest/utils/colors.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  void initState() {
    super.initState();
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
                            Text("Reset your\npassword",
                                style: heading1(context).copyWith(
                                  color: black,
                                  fontSize: 25,
                                )),
                            kTinyVerticalSpacing,
                            Text("Never lose access to your account 😍",
                                style: bodyTinyText(context).copyWith()),
                            SizedBox(height: size.height * 0.08),
                            const CText(
                              text: "Your Email*",
                              fontWeight: FontWeight.bold,
                              size: 14,
                              color: kBlackColor,
                            ),
                            const SizedBox(height: 10),
                            AuthTextField(
                              hint: "example@gmail.com",
                              prefixIcon: Icons.lock,
                              controller:
                                  resetPasswordController.emailController,
                              inputType: TextInputType.emailAddress,
                              error: resetPasswordController.error.value,
                              validFunction: (v) => v!,
                              onSavedFunction: (s) => {
                                if (s.isValidEmail())
                                  {
                                    resetPasswordController.email.value = s,
                                    resetPasswordController.error.value = ''
                                    //print(email);
                                  }
                                else
                                  {
                                    resetPasswordController.email.value = s,
                                    resetPasswordController.error.value =
                                        "Email not valid"
                                  }
                              },
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10),
                              child: CText(
                                text: resetPasswordController.error.value,
                                size: 12,
                                fontWeight: FontWeight.w400,
                                color: kErrorColor,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            const CText(
                              text:
                                  "Please enter your email address. An email verification link will be sent to you.",
                              fontWeight: FontWeight.w400,
                              size: 14,
                              color: kDarkGreyColor,
                              textAlign: TextAlign.start,
                            ),

                            //const Spacer(),
                            SizedBox(height: constraints.maxHeight * 0.2),

                            GestureDetector(
                              onTap: resetPasswordController.email.value.isEmpty
                                  ? () {
                                      cToast(
                                          msg:
                                              "Please check your email and password is correct",color: Colors.red);
                                    }
                                  : () {
                                      resetPasswordController
                                          .requestResetPassword();
                                    },
                              child: Container(
                                height: 70,
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
                                              text: "Reset password",
                                              fontWeight: FontWeight.w400,
                                              size: 16,
                                              color: kWhiteColor,
                                            ),
                                ),
                              ),
                            ),
                              kTinyVerticalSpacing,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?",
                                    style: bodySmallText(context)),
                                TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.SIGN_UP);
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: bodySmallText(context)
                                          .copyWith(color: kPrimaryColor),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Positioned.fill(
                //   child: Align(
                //     alignment: Alignment.topRight,
                //     child: GestureDetector(
                //       onTap: () {
                //         Get.toNamed(Routes.SIGN_UP);
                //       },
                //       child: Container(
                //         margin: EdgeInsets.only(top: size.height * 0.04),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: const [
                //             CText(
                //               text: "New User? ",
                //               fontWeight: FontWeight.w500,
                //               size: 16,
                //               color: kSecondaryColor,
                //             ),
                //             CText(
                //               text: "Create new account",
                //               fontWeight: FontWeight.w500,
                //               size: 16,
                //               color: kPrimaryColor,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            );
          }),
        ));
  }
}
