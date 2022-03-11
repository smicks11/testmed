import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/home/controller/home_controller.dart';
import 'package:medfest/utils/colors.dart';

class RemovedTransaction extends StatefulWidget {
  const RemovedTransaction({Key? key}) : super(key: key);

  @override
  State<RemovedTransaction> createState() => _RemovedTransactionState();
}

class _RemovedTransactionState extends State<RemovedTransaction> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    var data = homeController.historyData.toList();

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        DateTime time1 = DateTime.parse(data[index].date.toString());
        // print(convertToAgo(time1));
        if (data.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: kPrimaryColor,
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(curveRadius)),
                backgroundColor: const Color(0xFFF5F6F9),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: kErrorColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        text: data[index].transactionType,
                        fontWeight: FontWeight.w200,
                        size: 16,
                        color: kBlackColor,
                      ),
                      CText(
                        text: convertToAgo(time1),
                        fontWeight: FontWeight.w200,
                        size: 14,
                        color: kDarkGreyColor.withOpacity(0.5),
                      )
                    ],
                  ),
                  const Spacer(),
                  CText(
                    text: "+${data[index].amount}",
                    fontWeight: FontWeight.w500,
                    size: 18,
                    color: data[index].last4 != ""
                        ? Colors.green.shade500
                        : kErrorColor,
                  )
                ],
              ),
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
