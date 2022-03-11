import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/screens/app/home/controller/home_controller.dart';
import 'package:medfest/utils/colors.dart';
import 'package:medfest/utils/numeric_keyboard.dart';
import 'package:pinput/pin_put/pin_put.dart';

class EnterOTP extends StatefulWidget {
  const EnterOTP({Key? key}) : super(key: key);

  @override
  State<EnterOTP> createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  HomeController homeController = Get.find<HomeController>();
  bool load = false;

  final TextEditingController textController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: kPrimaryColor.withOpacity(0.8),
      border: Border.all(color: const Color(0xFFF7F1FD)),
      borderRadius: BorderRadius.circular(curveRadius),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  // width: 260,
                  //height: 60,
                  margin: const EdgeInsets.all(5.0),
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30, top: 40),
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
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                  ),
                ),
                Flexible(
                  child: ListView(
                    children: [
                      NumericKeyboard(
                        onKeyboardTap: (String val) {
                          setState(() {
                            textController.text = textController.text + val;
                          });
                        },
                        textColor: const Color(0xff4A4A4A),
                        rightButtonFn: () {
                          setState(() {
                            textController.text = textController.text
                                .substring(0, textController.text.length - 1);
                          });
                        },
                        rightIcon: const Icon(
                          Icons.backspace,
                          color: Color(0xff4A4A4A),
                        ),
                        leftButtonFn: () {
                          // print('left button clicked');
                        },
                        leftIcon: const Icon(
                          Icons.check,
                          color: Color(0xff4A4A4A),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => CupertinoButton(
                          padding: const EdgeInsets.all(5),
                          onPressed: textController.text.length < 4
                              ? null
                              : () {
                                  homeController.completeTransfer(
                                      otp: textController.text.trim());
                                  // startPayment(context);
                                },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: textController.text == ''
                                    ? kPrimaryColor.withOpacity(0.6)
                                    : kPrimaryColor,
                                borderRadius: BorderRadius.circular(40)),
                            height: 65,
                            width: 327,
                            child: homeController.loading.value == true
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kWhiteColor),
                                    strokeWidth: 1,
                                  )
                                : const Center(
                                    child: CText(
                                        text: "Continue",

                                        //fontFamily: 'AvenirNext-DemiBold',
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w600,
                                        size: 16,
                                        color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                      text: 'Transfer',
                      fontWeight: FontWeight.w600,
                      size: 26,
                      letterSpacing: 1.0,
                      color: kWhiteColor,
                    ),
                    SizedBox(height: size.height * 0.03),
                    const CText(
                      text:
                          'An email containing an OTP code has been sent to your registered Email Address.',
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
      ),
    );
  }
}
