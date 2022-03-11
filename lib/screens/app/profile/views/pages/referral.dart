import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';
import 'package:medfest/utils/colors.dart';
import 'package:share/share.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({Key? key}) : super(key: key);

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
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              color: kWhiteColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                Image.asset(referral),
                const Align(
                  alignment: Alignment.center,
                  child: CText(
                    text: "Refer & Earn",
                    fontWeight: FontWeight.bold,
                    size: 22,
                    color: kPrimaryColor,
                    letterSpacing: 2,
                    wordSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.center,
                  child: CText(
                    text:
                        "To activate you free healthcare, you must be an active subscriber.Refer 5 other people who must also be active subscribers",
                    fontWeight: FontWeight.normal,
                    size: 14,
                    color: Colors.black54,
                    letterSpacing: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  height: size.height * 0.05,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CText(
                          text: profileController.userData.value.referralCode,
                          size: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Share.share(
                              'Create an account with MEDFESTCARE and get amazing healthcare points for free medical access using this code *${profileController.userData.value.referralCode}* ');
                        },
                        child: Container(
                          height: size.height * 0.05,
                          width: size.width * 0.30,
                          decoration: const BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: CText(
                              text: "Share",
                              size: 22,
                              fontWeight: FontWeight.w700,
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
