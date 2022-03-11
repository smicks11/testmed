import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/auth_textfield.dart';
import 'package:medfest/components/snack_bar.dart';

import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/routes/app_pages.dart';
import 'package:medfest/screens/auth/login/controller/login_controller.dart';
import 'package:medfest/services/extension.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/app_textstyle.dart';
import 'package:medfest/utils/colors.dart';

import 'components/info_dailog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      showModal(
          configuration: const FadeScaleTransitionConfiguration(
            transitionDuration: Duration(milliseconds: 500),
          ),
          context: context,
          builder: (_) {
            return const LoginDialog();
          });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var loginController = Get.find<LoginController>();

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
                            Text("Welcome back 🎉",
                                style: heading1(context).copyWith(
                                  color: black,
                                  fontSize: 25,
                                )),
                            kTinyVerticalSpacing,
                            Text(" Sign in to continue",
                                style: bodyTinyText(context).copyWith()),
                            //SizedBox(height: size.height * 0.02),
                            // const CText(
                            //   text: "Log in",
                            //   fontWeight: FontWeight.w700,
                            //   size: 30,
                            //   color: kBlackColor,
                            // ),
                            // const SizedBox(height: 10),
                            // const CText(
                            //   text: "to Continue 🎉",
                            //   fontWeight: FontWeight.w700,
                            //   size: 30,
                            //   color: kBlackColor,
                            // ),
                            SizedBox(height: size.height * 0.08),
                            const CText(
                              text: "Your Email",
                              fontWeight: FontWeight.bold,
                              size: 13,
                              color: kBlackColor,
                            ),
                            const SizedBox(height: 10),
                            AuthTextField(
                              hint: "example@gmail.com",
                              prefixIcon: Icons.lock,
                              controller: loginController.emailController,
                              inputType: TextInputType.emailAddress,
                              error: loginController.error.value,
                              validFunction: (v) => v!,
                              onSavedFunction: (s) => {
                                if (s.isValidEmail())
                                  {
                                    loginController.email.value = s,
                                    loginController.error.value = ''
                                    //print(email);
                                  }
                                else
                                  {
                                    loginController.email.value = s,
                                    loginController.error.value =
                                        "Email not valid"
                                  }
                              },
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10),
                              child: CText(
                                text: loginController.error.value,
                                size: 12,
                                fontWeight: FontWeight.w400,
                                color: kErrorColor,
                              ),
                            ),
                            kTinyVerticalSpacing,
                            // SizedBox(height: size.height * 0.01),
                            const CText(
                              text: "Password",
                              fontWeight: FontWeight.bold,
                              size: 13,
                              color: kBlackColor,
                            ),
                            const SizedBox(height: 10),
                            AuthTextField(
                              hint: "Password",
                              prefixIcon: Icons.lock,
                              controller: loginController.passwordController,
                              inputType: TextInputType.visiblePassword,
                              error: loginController.error1.value,
                              isPassword: true,
                              validFunction: (v) => v!,
                              onSavedFunction: (s) => {
                                if (s.isValidPassword())
                                  {
                                    loginController.password.value = s,
                                    loginController.error1.value = ''
                                    //print(email);
                                  }
                                else
                                  {
                                    loginController.password.value = s,
                                    loginController.error1.value =
                                        "Password should contain at least 1 upper case, 1 lower case, 1 digit and at least 8 characters in length"
                                  }
                              },
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10),
                              child: CText(
                                text: loginController.error1.value,
                                size: 12,
                                fontWeight: FontWeight.w400,
                                color: kErrorColor,
                              ),
                            ),
                            // SizedBox(height: size.height * 0.01),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.RESET_PASSWORD);
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: const CText(
                                  text: "Forgot Password?",
                                  fontWeight: FontWeight.w400,
                                  size: 14,
                                  //color: kBlackColor,
                                ),
                              ),
                            ),
                            //const Spacer(),
                            SizedBox(height: constraints.maxHeight * 0.1),

                            GestureDetector(
                              onTap: loginController.email.value.isEmpty &&
                                      loginController.password.value.isEmpty
                                  ? () {
                                      cToast(
                                          msg:
                                              "Please check your email and password is correct",
                                          color: Colors.red);
                                    }
                                  : () {
                                      loginController.login();
                                    },
                              child: Container(
                                height: 70,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius:
                                        BorderRadius.circular(curveRadius)),
                                child: Center(
                                  child: loginController.loading.value == true
                                      ? const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  kWhiteColor),
                                          strokeWidth: 1,
                                        )
                                      : const CText(
                                          text: "Sign in",
                                          // fontWeight: FontWeight.w400,
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
