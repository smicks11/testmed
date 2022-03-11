import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/home/views/pages/pay_bils.dart';
import 'package:medfest/screens/app/pay/views/components/fund_modal.dart';
import 'package:medfest/screens/app/pay/views/pages/scan_code.dart';
import 'package:medfest/screens/app/pay/views/pages/transfer.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';
import 'package:medfest/utils/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ActionRow extends StatelessWidget {
  final double width;
  final double height;
  const ActionRow({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    double HEIGTH = MediaQuery.of(context).size.height;
    double WIDTH = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            margin: EdgeInsets.only(left: WIDTH * 0.1, right: WIDTH * 0.1),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,

              children: [
                Expanded(
                  child: item(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * 0.30,
                    title: " Fund\nWallet",
                    icon: Feather.upload,
                    callback: () {
                      if (profileController.userData.value.emailVerification ==
                          "not verified") {
                        cToast(
                            msg:
                                "Please verify your email to fund your account",color: Colors.red);
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
                            height: MediaQuery.of(context).size.height * 0.70,
                            child: const FundWallet(),
                          ),
                        );
                      }
                    },
                  ),
                ),
                //SizedBox(width: constraints.maxWidth * 0.01),
                Expanded(
                  child: item2(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth * 0.30,
                      title: " Pay\nBills",
                      icon: Feather.download,
                      callback: () {
                        Get.to(() => const PayBills());
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget item({
    required double height,
    required double width,
    required String title,
    VoidCallback? callback,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        height: height,
        // width: width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                kPrimaryColor.withOpacity(0.9),
                kPrimaryColor,
                kPrimaryColor,
              ],
            ),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 3,
                  color: Colors.grey[200]!,
                  offset: const Offset(2, 4)),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: kWhiteColor,
              size: 30,
            ),
            const Spacer(),
            CText(
              text: title,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              size: 16,
              color: kWhiteColor,
              letterSpacing: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget item2({
    required double height,
    required double width,
    required String title,
    VoidCallback? callback,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        // margin: const EdgeInsets.only(left: 20),
        height: height,
        // width: width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kWhiteColor,
            boxShadow: [
              BoxShadow(
                spreadRadius: 3,
                blurRadius: 3,
                color: Colors.grey[100]!,
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: kPrimaryColor,
              size: 30,
            ),
            const Spacer(),
            CText(
              text: title,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              size: 16,
              color: kPrimaryColor,
              letterSpacing: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget item3({
    required double height,
    required double width,
    VoidCallback? callback,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        // margin: const EdgeInsets.only(left: 20),
        height: height,
        width: width,
        //padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kWhiteColor,
            boxShadow: [
              BoxShadow(
                spreadRadius: 3,
                blurRadius: 3,
                color: Colors.grey[100]!,
              ),
            ]),
        child: Center(
          child: Icon(
            icon,
            color: kTextFieldColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
