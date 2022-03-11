import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/profile/views/components/faq.dart';
import 'package:medfest/screens/app/profile/views/components/item_tiles.dart';
import 'package:medfest/screens/app/profile/views/pages/referral.dart';
import 'package:medfest/utils/colors.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.8),
          ),
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.20),
            child: SvgPicture.asset(
              security,
              height: 233,
              width: 233,
            ),
          ),
        ),
        Container(
          height: size.height,
          width: size.width,
          margin: EdgeInsets.only(top: size.height * 0.55),
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
                ItemTile(
                  itemName: 'Refer and Earn',
                  callback: () {
                    Get.to(() => const ReferralPage());
                  },
                  // trailing: "Verified",
                ),
                SizedBox(height: size.height * 0.03),
                ItemTile(
                    itemName: 'Frequently Asked Questions',
                    callback: () => Get.to(() => FAQ())),
                SizedBox(height: size.height * 0.03),
                ItemTile(
                    itemName: 'Contact Support',
                    callback: () => Get.to(() => FAQ())),
              ],
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
              color: kTextColor,
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
                    text: 'Help & Support',
                    fontWeight: FontWeight.w600,
                    size: 26,
                    letterSpacing: 1.0,
                  ),
                  SizedBox(height: size.height * 0.03),
                  const CText(
                    text: '',
                    fontWeight: FontWeight.w400,
                    size: 15,
                    letterSpacing: 1.0,
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
