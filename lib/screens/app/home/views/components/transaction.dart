import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/home/controller/home_controller.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';
import 'package:medfest/utils/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:medfest/services/extension.dart';

class TransactionHistory extends StatelessWidget {
  final double heightPercentage;
  const TransactionHistory({Key? key, required this.heightPercentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var homeController = Get.find<HomeController>();
    var profileController = Get.find<ProfileController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Obx(
        () => SizedBox(
          height: size.height * heightPercentage,
          child: ListView.builder(
            itemCount: homeController.historyData.length,
            itemBuilder: (context, index) {
              DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
              String date =
                  dateFormat.format(homeController.historyData[index].date);

              DateTime time1 = DateTime.parse(
                  homeController.historyData[index].date.toString());
              // print(convertToAgo(time1));
              if (homeController.historyData.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kWhiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200]!,
                            blurRadius: 2,
                            offset: const Offset(4, 2))
                      ]),
                  child: Row(
                    children: [
                      Image.asset(
                        payment,
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => CText(
                              text:
                                  homeController.historyData[index].last4 != ""
                                      ? "Funded Account"
                                      : "Made Payment",
                              fontWeight: FontWeight.w600,
                              size: 20,
                            ),
                          ),
                          CText(
                            text: convertToAgo(time1),
                            fontWeight: FontWeight.w400,
                            size: 14,
                            color: kErrorColor,
                          )
                        ],
                      ),
                      const Spacer(),
                      CText(
                        text: "+${homeController.historyData[index].amount}",
                        fontWeight: FontWeight.w500,
                        size: 18,
                        color: homeController.historyData[index].last4 != ""
                            ? Colors.green.shade500
                            : kErrorColor,
                      )
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(notransaction),
                    const SizedBox(height: 10),
                    const CText(
                      text: "No Transactions Yet",
                      color: kTextColor,
                      size: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    
    );
  }

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays} day(s) ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour(s) ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }
}
