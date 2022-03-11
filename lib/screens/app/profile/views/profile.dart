import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/routes/app_pages.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';
import 'package:medfest/screens/app/profile/views/pages/verify_bvn.dart';
import 'package:medfest/services/storage.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/app_textstyle.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../utils/colors.dart';
import 'components/draggable_fab.dart';
import 'components/faq.dart';
import 'components/item_tiles.dart';
import 'components/logout.dart';
import 'components/profile_item.dart';

import 'components/search_container.dart';
import 'pages/notification_settings.dart';
import 'pages/personal_info.dart';
import 'pages/referral.dart';
import 'pages/verify_email.dart';
import 'pages/wallet_address.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey _parentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var profileController = Get.find<ProfileController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.06),
            const Align(
              alignment: Alignment.topCenter,
              child: CText(
                text: "Settings",
                fontWeight: FontWeight.w700,
                size: 15,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            const SearchContainer(),
            SizedBox(height: size.height * 0.04),
            Stack(
              key: _parentKey,
              children: [
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: CText(
                        text: "Profile",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                    ),
                    Item(
                      callback: () {
                        Get.to(() => const PersonalInfo());
                      },
                      itemName: "Personal Information",
                      image: personal,
                    ),
                    Item(
                      callback: () {
                        Get.to(() => const WalletAddress());
                      },
                      itemName: "Wallet Info",
                      image: messages,
                    ),
                    Item(
                      callback: () {
                        Get.to(() => const ReferralPage());
                      },
                      itemName: "Refer and Earn",
                      image: messages,
                    ),
                    SizedBox(height: size.height * 0.02),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: CText(
                        text: "Settings",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                    ),
                    Item(
                      callback: () {},
                      itemName: "Preferences",
                      image: preferences,
                    ),
                    Item(
                      callback: () {
                        Get.to(() => const NotificationSettings());
                      },
                      itemName: "Notification Settings",
                      image: notification,
                    ),
                    Item(
                      callback: () {
                        if (profileController
                                .userData.value.emailVerification ==
                            "not verified") {
                          Get.to(() => const VerifyEmail());
                        } else if (profileController.userData.value.bvn ==
                            null) {
                          Get.to(() => const VerifyBVN());
                        } else {
                          cToast(msg: "Already Verified",color: Colors.green);
                        }
                      },
                      itemName: "Verification",
                      image: qrsettings,
                      showTrailing: true,
                      icon: profileController.userData.value.fullyVerified ==
                              "not fully verified"
                          ? Icons.close
                          : Icons.done,
                      iconColor:
                          profileController.userData.value.fullyVerified ==
                                  "not fully verified"
                              ? kErrorColor
                              : kPrimaryColor,
                    ),
                    SizedBox(height: size.height * 0.02),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: CText(
                        text: "Security",
                        fontWeight: FontWeight.w700,
                        size: 16,
                      ),
                    ),
                    Item(
                      callback: () {
                        Get.to(() => FAQ());
                      },
                      itemName: "FAQs",
                      image: fundaccount,
                    ),
                  ],
                ),
                DraggableFloatingActionButton(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: ShapeDecoration(
                      shadows: [
                        BoxShadow(
                          color: Colors.grey[200]!,
                          spreadRadius: 4,
                        ),
                      ],
                      shape: const CircleBorder(),
                      //color: kPrimaryColor,
                    ),
                    child: const Icon(
                      Entypo.log_out,
                      //color: kWhiteColor,
                    ),
                  ),
                  initialOffset: const Offset(2, 4),
                  parentKey: _parentKey,
                  onPressed: () {
                    //log('Button is clicked');
                    showBarModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        barrierColor: Colors.black.withOpacity(.6),
                        duration: const Duration(milliseconds: 100),
                        context: context,
                        builder: (context) => SizedBox(
                              height: MediaQuery.of(context).size.height * 0.30,
                              child: const Logout(),
                            ));
                  },
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 80),
        child: DraggableFab(
          child: FloatingActionButton(
            backgroundColor: kWhiteColor,
            onPressed: () {
              //log('Button is clicked');
              showBarModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  barrierColor: Colors.black.withOpacity(.6),
                  duration: const Duration(milliseconds: 100),
                  context: context,
                  builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.30,
                        child: const Logout(),
                      ));
            },
            child: const Icon(
              Entypo.log_out,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var profileController = Get.find<ProfileController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kLargeVerticalSpacing,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "Profile",
                  style: bodyNormalText(context).copyWith(fontSize:30, color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ),
              // Align(
              //   child: Image.asset(
              //     logo,
              //     height: 200,
              //   ),
              // ),
              const SizedBox(height: 20),
              ProfileMenu(
                text: "My Account",
                icon: Feather.user,
                press: () {
                  Get.to(() => const PersonalInfo());
                },
              ),
              ProfileMenu(
                text: "My Wallet",
                icon: Feather.layout,
                press: () {
                  Get.to(() => const WalletAddress());
                },
              ),
              ProfileMenu(
                text: "Refer and Earn",
                icon: Feather.layers,
                press: () {
                  Get.to(() => const ReferralPage());
                },
              ),
              ProfileMenu(
                text: "Verification",
                icon: Feather.check_square,
                press: () {
                  if (profileController.userData.value.emailVerification ==
                      "not verified") {
                    Get.to(() => const VerifyEmail());
                  } else if (profileController.userData.value.bvn == null) {
                    Get.to(() => const VerifyBVN());
                  } else {
                    cToast(msg: "Already Verified",color: Colors.green);
                  }
                },
              ),
              ProfileMenu(
                text: "Log Out",
                icon: Feather.log_out,
                press: () async {
                  await box.erase();

                  Get.offNamedUntil(Routes.ONBOARD_SCREEN, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
