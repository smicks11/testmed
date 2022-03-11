import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/terms_of_use.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/auth/signup/controller/signup_controller.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/app_textstyle.dart';
import 'package:medfest/utils/back_button.dart';
import 'package:medfest/utils/colors.dart';
import 'package:medfest/components/auth_textfield.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/services/extension.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'components/account_type.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final List<String> _accountType = [
    "PATIENT",
    "HOSPITAL",
  ];

  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var signupController = Get.find<SignupController>();

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
                    height: size.height * 1.0,
                    color: kWhiteColor,
                    margin: EdgeInsets.only(top: size.height * 0.054),
                    //padding: const EdgeInsets.all(18),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //SizedBox(height: size.height * 0.02),
                          Text("Sign up 🎉",
                                style: heading1(context).copyWith(
                                  color: black,
                                  fontSize: 25,
                                )),
                            kTinyVerticalSpacing,
                            Text("Begin a hassle free and healthy journey 😍",
                                style: bodyTinyText(context).copyWith()),
                          SizedBox(height: size.height * 0.04),
                          const CText(
                            text: "Your Name",
                            fontWeight: FontWeight.bold,
                            size: 13,
                            color: kBlackColor,
                          ),
                          kTinyVerticalSpacing,
                          AuthTextField(
                            hint: "Emmanuel Felix",
                            prefixIcon: Icons.person,
                            controller: signupController.nameController,
                            inputType: TextInputType.name,
                            error: signupController.error2.value,
                            validFunction: (v) => v!,
                            onSavedFunction: (s) => {
                              if (s.contains(" ") && s.length > 5)
                                {
                                  signupController.name.value = s,
                                  signupController.error2.value = ''
                                  //print(email);
                                }
                              else
                                {
                                  signupController.name.value = s,
                                  signupController.error2.value =
                                      "Make sure you enter your full name"
                                }
                            },
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.all(10),
                            child: CText(
                              text: signupController.error2.value,
                              size: 10,
                              fontWeight: FontWeight.w400,
                              color: kErrorColor,
                            ),
                          ),
                          const CText(
                            text: "Your Email",
                            fontWeight: FontWeight.bold,
                            size: 13,
                            color: kBlackColor,
                          ),
                          kTinyVerticalSpacing,
                          AuthTextField(
                            hint: "example@gmail.com",
                            prefixIcon: Icons.lock,
                            controller: signupController.emailController,
                            inputType: TextInputType.emailAddress,
                            error: signupController.error.value,
                            validFunction: (v) => v!,
                            onSavedFunction: (s) => {
                              if (s.isValidEmail())
                                {
                                  signupController.email.value = s,
                                  signupController.error.value = ''
                                  //print(email);
                                }
                              else
                                {
                                  signupController.email.value = s,
                                  signupController.error.value =
                                      "Email not valid"
                                }
                            },
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.all(10),
                            child: CText(
                              text: signupController.error.value,
                              size: 12,
                              fontWeight: FontWeight.w400,
                              color: kErrorColor,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          const CText(
                            text: "Referral code",
                            fontWeight: FontWeight.bold,
                            size: 13,
                            color: kBlackColor,
                          ),
                          kTinyVerticalSpacing,
                          AuthTextField(
                            hint: "Optional",
                            prefixIcon: Icons.phone,
                            controller: signupController.refferalcontroller,
                            inputType: TextInputType.name,
                            error: signupController.error3.value,
                            validFunction: (v) => v!,
                            onSavedFunction: (s) => {
                              signupController.referral_code.value = s,
                              signupController.error3.value = ''
                              //print(email);
                            },
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.all(10),
                            child: CText(
                              text: signupController.error3.value,
                              size: 12,
                              fontWeight: FontWeight.w400,
                              color: kErrorColor,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          const CText(
                            text: "Password",
                            fontWeight: FontWeight.bold,
                            size: 13,
                            color: kBlackColor,
                          ),
                          kTinyVerticalSpacing,
                          AuthTextField(
                            hint: "Password",
                            prefixIcon: Icons.lock,
                            controller: signupController.passwordController,
                            inputType: TextInputType.visiblePassword,
                            error: signupController.error1.value,
                            isPassword: true,
                            validFunction: (v) => v!,
                            onSavedFunction: (s) => {
                              if (s.isValidPassword())
                                {
                                  signupController.password.value = s,
                                  signupController.error1.value = ''
                                  //print(email);
                                }
                              else
                                {
                                  signupController.password.value = s,
                                  signupController.error1.value =
                                      "Password should contain at least 1 upper case, 1 lower case, 1 digit and at least 8 characters in length"
                                }
                            },
                          ),
                          SizedBox(height: size.height * 0.04),
                          const CText(
                            text: "Confirm Password",
                            fontWeight: FontWeight.bold,
                            size: 13,
                            color: kBlackColor,
                          ),
                          kTinyVerticalSpacing,
                          AuthTextField(
                            hint: "Confirm Password",
                            prefixIcon: Icons.lock,
                            controller:
                                signupController.confirmpasswordController,
                            inputType: TextInputType.visiblePassword,
                            error: signupController.error1.value,
                            isPassword: true,
                            validFunction: (v) => v!,
                            onSavedFunction: (s) => {
                              if (s == signupController.password.value)
                                {
                                  signupController.confirmpassword.value = s,
                                  signupController.error1.value = ''
                                  //print(email);
                                }
                              else
                                {
                                  signupController.confirmpassword.value = s,
                                  signupController.error1.value =
                                      "Password do not match"
                                }
                            },
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.all(10),
                            child: CText(
                              text: signupController.error1.value,
                              size: 12,
                              fontWeight: FontWeight.w400,
                              color: kErrorColor,
                            ),
                          ),
                          // SizedBox(height: size.height * 0.01),

                          //const Spacer(),
                          SizedBox(height: size.height * 0.05),
                          GestureDetector(
                            onTap: signupController.email.value.isEmpty ||
                                    signupController.password.value.isEmpty ||
                                    signupController.name.value.isEmpty ||
                                    signupController.confirmpassword.value !=
                                        signupController.password.value
                                ? () {
                                    cToast(
                                        msg:
                                            "Please ensure the fields have been filled correctly",color: Colors.red);
                                  }
                                : () {
                                    print(signupController.password.value);
                                    print(
                                        signupController.confirmpassword.value);
                                    // Get.toNamed('/mainview');
                                    showBarModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30)),
                                      ),
                                      barrierColor:
                                          Colors.black.withOpacity(.6),
                                      duration:
                                          const Duration(milliseconds: 100),
                                      context: context,
                                      builder: (context) => SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.40,
                                        child: const AccountType(),
                                      ),
                                    );
                                  },
                            child: Container(
                              height: 70,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius:
                                      BorderRadius.circular(curveRadius)),
                              child: Center(
                                child: signupController.loading.value == true
                                    ? const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                kWhiteColor),
                                        strokeWidth: 1,
                                      )
                                    : const CText(
                                        text: "Register now 😍",
                                        // fontWeight: FontWeight.w400,
                                        size: 16,
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
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.offNamed('/login');
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            CText(
                              text: "Have an account? ",
                              fontWeight: FontWeight.w500,
                              size: 12,
                              color: black,
                            ),
                            CText(
                              text: "Log in",
                              fontWeight: FontWeight.w500,
                              size: 14,
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
          })),
    );
  }
}

class TextInput extends StatelessWidget {
  final String textString;
  final TextEditingController textController;
  final String hint;
  final bool obscureText;

  const TextInput(
      {Key? key,
      required this.textString,
      required this.textController,
      required this.hint,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color(0xFF000000)),
      cursorColor: const Color(0xFF9b9b9b),
      controller: textController,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: textString,
        hintStyle: const TextStyle(
            color: Color(0xFF9b9b9b),
            fontSize: 12,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
