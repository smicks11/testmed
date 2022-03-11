import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/routes/app_pages.dart';
import 'package:medfest/services/storage.dart';
import 'package:medfest/utils/colors.dart';

class OnboardingScreenOne extends StatefulWidget {
  const OnboardingScreenOne({Key? key}) : super(key: key);

  @override
  State<OnboardingScreenOne> createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne> {
  int currentIndex = 0;

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(choice),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: CText(
                                text: "Welcome",
                                fontWeight: FontWeight.w600,
                                size: 25,
                                color: kWhiteColor,
                                bold: true,
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: CText(
                                text:
                                    "MEDFESTCARE: You don't have to worry about healthcare bills anymore ",
                                color: kWhiteColor,
                                fontWeight: FontWeight.w600,
                                size: 14,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.04),
                            GestureDetector(
                              onTap: () async {
                                await Storage.setStep("login");
                                Get.offAllNamed(Routes.LOGIN);
                              },
                              child: Container(
                                height: 60,
                                width: constraints.maxWidth,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius:
                                        BorderRadius.circular(curveRadius)),
                                child: const Center(
                                  child: CText(
                                    text: "Sign in",
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w600,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.02),
                            GestureDetector(
                              onTap: () async {
                                await Storage.setStep("sign_up");
                                Get.offAllNamed(Routes.SIGN_UP);
                              },
                              child: Container(
                                height: 60,
                                width: constraints.maxWidth,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: kWhiteColor, width: 1.5),
                                    borderRadius:
                                        BorderRadius.circular(curveRadius)),
                                child: const Center(
                                  child: CText(
                                    text: "Create an account",
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w600,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: kBackgroundColor,
    //   body: Padding(
    //     padding: const EdgeInsets.all(18.0),
    //     child: LayoutBuilder(
    //       builder: (context, constraints) {
    //         return Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             SizedBox(
    //               height: constraints.maxHeight * 0.1,
    //             ),
    //             Image.asset(doctor),
    // const CText(
    //   text: "Welcome to\n MEDFESTCARE ",
    //   fontWeight: FontWeight.w600,
    //   size: 40,
    //   color: kBlackColor,
    //   bold: true,
    // ),
    //             const CText(
    //               text: "Lorem ipsum dolor sit amet ",
    //             ),
    //             SizedBox(
    //               height: constraints.maxHeight * 0.1,
    //             ),
    //             GestureDetector(
    //               onTap: () async {
    // await Storage.setStep("login");
    // Get.offAllNamed('/login');
    //               },
    //               child: Container(
    //                 height: 60,
    //                 width: constraints.maxWidth * 0.40,
    //                 padding: const EdgeInsets.all(18.0),
    //                 // ignore: prefer_const_constructors
    //                 decoration: BoxDecoration(
    //                   color: kPrimaryColor,
    //                   borderRadius: BorderRadius.circular(curveRadius),
    //                 ),
    // child: const Center(
    //   child: CText(
    //     text: "Start Now",
    //     color: kWhiteColor,
    //     fontWeight: FontWeight.w600,
    //     size: 18,
    //   ),
    // ),
    //               ),
    //             )
    //           ],
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}
