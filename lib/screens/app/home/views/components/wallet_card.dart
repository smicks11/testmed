import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/home/controller/home_controller.dart';
import 'package:medfest/screens/app/home/views/components/subscription.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/colors.dart';

class WalletCard extends StatelessWidget {
  final double width;
  final double height;
  const WalletCard({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    var profileController = Get.find<ProfileController>();
    log(homeController.walletInfo.value.totalBalance.toString());
    Size size = MediaQuery.of(context).size;
    //var WIDTH = 100.0;
    return Container(
        height: height,
        width: width,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            // color: const Color.fromRGBO(0, 100, 237, 1),
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200]!,
                  blurRadius: 4,
                  spreadRadius: 2,
                  offset: const Offset(4, 8))
            ]),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CustomPaint(
                    size: Size(
                      size.width,
                      (size.width * 0.6666666666666666).toDouble(),
                    ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainter(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(height: constraints.maxHeight * 0.35),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(
                          () => CText(
                            text: profileController.userData.value.fullName,
                            letterSpacing: 1,
                            color: white,
                            size: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CText(
                          text: "Balance",
                          letterSpacing: 1,
                          color: white.withOpacity(0.7),
                          size: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        children: [
                          const Text("₦",
                              style: TextStyle(
                                letterSpacing: 1,
                                color: white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              )),
                          Obx(
                            () => CText(
                              text: homeController.walletInfo.value.totalBalance
                                  .toString(),
                              letterSpacing: 1,
                              color: white,
                              size: 35,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const Spacer(),
                          Obx(
                            () => profileController
                                        .userData.value.subscriberStatus ==
                                    "not subscription yet"
                                ? GestureDetector(
                                    onTap: () async {
                                      Get.to(() => const UserSubscription());
                                      final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const UserSubscription(),
                                          ));
                                      if (result != null) {
                                        cToast(msg: result,color:Colors.blueAccent);
                                        homeController.getWalletInfo();
                                        homeController.getTransactionHistory();
                                        profileController.getUserProfileData();
                                      } else {
                                        cToast(msg: "Subscription Failed",color: Colors.green);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Center(
                                        child: CText(
                                          text: "Subscribe",
                                          letterSpacing: 1,
                                          color: kWhiteColor,
                                          size: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  )
                                : CText(
                                    text: profileController
                                        .userData.value.subscriberStatus,
                                    letterSpacing: 1,
                                    color: white,
                                    size: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Obx(
                      () => profileController.userData.value.badge==null?
                      Container(
                        padding:const EdgeInsets.all(22),
                        width: size.width*0.4,
                          child: const CText(text: "No badge currently",color: Colors.white,fontWeight: FontWeight.normal,size: 10,)):
                      Image.asset(
                        getbadge(profileController.userData.value.badge),
                        height: 120,
                      )
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }

  String getbadge(badgeState) {
    if (badgeState == null) {
      return vhs;
    } else if (badgeState == "VHS") {
      return vhs;
    } else if (badgeState == "HS") {
      return vhs;
    } else if (badgeState == "VETERAN") {
      return ultimate;
    } else {
      return "";
    }
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0033333, 0);
    path0.quadraticBezierTo(size.width * 0.1725000, size.height * 0.4937500,
        size.width * 0.5000000, size.height * 0.5050000);
    path0.quadraticBezierTo(size.width * 0.8325000, size.height * 0.5000000,
        size.width * 0.9966667, size.height * 0.0050000);
    path0.cubicTo(
        size.width * 0.7483333,
        size.height * 0.0037500,
        size.width * 0.7483333,
        size.height * 0.0037500,
        size.width * 0.0033333,
        0);
    path0.close();

    canvas.drawPath(path0, paint0);

    Paint paint1 = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path1 = Path();
    path1.moveTo(size.width, size.height * 0.9900000);
    path1.quadraticBezierTo(size.width * 0.7000000, size.height * 0.9162500,
        size.width * 0.6800000, size.height * 0.4900000);
    path1.quadraticBezierTo(size.width * 0.6966667, size.height * 0.0675000,
        size.width * 0.9966667, 0);
    path1.cubicTo(size.width * 0.9966667, size.height * 0.2387500, size.width,
        size.height * 0.2587500, size.width, size.height * 0.9900000);
    path1.close();

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
