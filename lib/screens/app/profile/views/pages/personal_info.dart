import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';
import 'package:medfest/screens/app/profile/views/components/info_item.dart';
import 'package:medfest/utils/colors.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
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
            child: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //SizedBox(height: size.height * 0.04),
                  InfoItemTile(
                      title: "First Name",
                      callback: () {},
                      subtitle: profileController.userData.value.fullName
                          .split(' ')
                          .first,
                      showDivider: true),
                  InfoItemTile(
                      title: "Last Name",
                      callback: () {},
                      subtitle:
                          profileController.userData.value.fullName.split(' ')[1],
                      showDivider: true),
                  InfoItemTile(
                      title: "Email",
                      callback: () {},
                      subtitle: profileController.userData.value.email,
                      showDivider: true),
                  InfoItemTile(
                      title: "Password",
                      callback: () {
                        cToast(msg: "Cannot view password at the moment",color: Colors.red);
                      },
                      subtitle: '*************',
                      showDivider: true),

                  InfoItemTile(
                      title: "Account Type",
                      callback: () {},
                      subtitle: profileController.userData.value.accountType,
                      showDivider: true
                  ),
                  InfoItemTile(
                      title: "Account Type",
                      callback: () {},
                      subtitle: profileController.userData.value.accountType,
                      showDivider: true
                  ), 
                  InfoItemTile(
                      title: "Referral code",
                      callback: () {},
                      subtitle: profileController.userData.value.referralCode,
                      showDivider: true
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 55,
            left: 10,
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
                      text: 'Personal Information',
                      fontWeight: FontWeight.w600,
                      size: 22,
                      letterSpacing: 1.0,
                      color: kWhiteColor,
                    ),
                    SizedBox(height: size.height * 0.03),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child:  CText(
                        text: 'We got your personal information from the verification process. If you want to make changes on your personal information, contact our support.',
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                        size: 12,
                        letterSpacing: 0.5,
                        color: kWhiteColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      ],
    ),
        ));
  }
}
