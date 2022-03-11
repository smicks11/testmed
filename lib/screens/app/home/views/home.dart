// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/home/controller/home_controller.dart';
import 'package:medfest/screens/app/home/views/components/action_rows.dart';
import 'package:medfest/screens/app/home/views/pages/transaction.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/app_textstyle.dart';
import 'package:medfest/utils/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../pay/views/components/fund_modal.dart';
import '../../profile/controller/profile_controller.dart';
import 'components/all_transaction.dart';
import 'components/transaction.dart';
import 'components/wallet_card.dart';
import 'pages/pay_bils.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Good morning!';
      }
      if (hour < 17) {
        return 'Good afternoon!';
      }
      return 'Good Evening';
    }

    Size size = MediaQuery.of(context).size;
    var homeController = Get.find<HomeController>();
    homeController.refreshData();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.03),
                  // const CText(
                  //   text: greeting(),
                  //   letterSpacing: 1,
                  //   color: kPrimaryColor,
                  //   size: 25,
                  //   fontWeight: FontWeight.w400,
                  //   bold: true,
                  // ),
                  SizedBox(height: constraints.maxHeight * 0.03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPad - 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Hey, ${profileController.userData.value.fullName.split(' ')[0]}🙂",
                            style: heading1(context)
                                .copyWith(fontSize: 20, color: kPrimaryColor)),
                        kTinyVerticalSpacing,
                        Text(
                          "Enjoy being healthy!",
                          style: bodySmallText(context),
                        )
                      ],
                    ),
                  ),
                  kLargeVerticalSpacing,
                  WalletCard(
                    height: constraints.maxHeight * 0.30,
                    width: constraints.maxWidth,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.03),
                  Padding(padding: EdgeInsets.symmetric(horizontal: kPad), child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Explore Our Features 🔥', style: bodyNormalText(context).copyWith(color: kPrimaryColor, fontSize: 16),),
                    // kTinyVerticalSpacing,
                    // Text('START SOMETHING TIMELESS', style: bodyNormalText(context).copyWith(color: Colors.black54, fontSize: 10),)
                  ],),),
                  kLargeVerticalSpacing,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPad),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (profileController
                                    .userData.value.emailVerification ==
                                "not verified") {
                              cToast(
                                  msg:
                                      "Please verify your email to fund your account",
                                  color: Colors.red);
                            } else {
                              showBarModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                barrierColor: Colors.black.withOpacity(.6),
                                duration: const Duration(milliseconds: 100),
                                context: context,
                                builder: (context) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.70,
                                  child: const FundWallet(),
                                ),
                              );
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                leading: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white30,
                                        )),
                                    child: Icon(
                                      Icons.monetization_on,
                                      color: kPrimaryColor,
                                      size: 18,
                                    )),
                                title: Text(
                                  'Fund wallet 🤳',
                                  style: heading2(context)
                                      .copyWith(color: kPrimaryColor,),
                                ),
                              )),
                        ),
                        kMediumVerticalSpacing,
                        InkWell(
                          onTap: () {
                             Get.to(() => const PayBills());
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                leading: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white30,
                                        )),
                                    child: Icon(
                                      Icons.payment,
                                      color: Colors.white,
                                      size: 14,
                                    )),
                                title: Text(
                                  'Pay Bills 💳💵',
                                  style:
                                      heading2(context).copyWith(color: kWhiteColor),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  //Divider(),
                  // ActionRow(
                  //   height: constraints.maxHeight * 0.10,
                  //   width: constraints.maxWidth,
                  // ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  GestureDetector(
                    onTap: () => Get.to(() => const Transactions()),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CText(
                            text: "Activities",
                            color: Color(0xFF243656),
                            size: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          CText(
                            text: "View All",
                            size: 14,
                            fontWeight: FontWeight.w200,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      height: constraints.maxHeight * 0.30,
                      width: constraints.maxWidth,
                      child: const AllTransaction())
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
