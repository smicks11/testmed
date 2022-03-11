import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/screens/app/home/controller/home_controller.dart';
import 'package:medfest/screens/app/home/views/components/transfer_funds.dart';
import 'package:medfest/screens/app/home/views/components/donate_funds.dart';
import 'package:medfest/utils/colors.dart';
import 'package:medfest/utils/tab.dart';

import '../../../../../utils/app_spacing.dart';
import '../../../../../utils/app_textstyle.dart';
import '../components/added_transaction.dart';
import '../components/all_transaction.dart';
import '../components/pay_medical.dart';
import '../components/removed_transaction.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        // title: const CText(
        //   text: "Pay Bills",
        //   fontWeight: FontWeight.w400,
        //   size: 20,
        //   color: kBlackColor,
        // ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kBlackColor,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        margin: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Activities",
                                    style: heading1(context).copyWith(
                                        fontSize: 30,
                                        color: black,
                                        fontWeight: FontWeight.bold)),
                                kTinyVerticalSpacing,
                                Text(
                                  "See Activities!",
                                  style: bodySmallText(context)
                                      .copyWith(color: kTextFieldColor),
                                )
                              ],
                            ),
                            kLargeVerticalSpacing,
                            TabSelect(
                              firstTab: "All",
                              secondTab: "Added",
                              thirdTab: "Remove",
                              indicatorColor: white,
                              labelColor: kPrimaryColor,
                              bdgColor: kPrimaryColor,
                              tabController: _tabController,
                            ),
                            kSmallVerticalSpacing,
                            Expanded(
                              child: TabBarView(
                                  controller: _tabController,
                                  children: const [
                                    AllTransaction(),
                                    AddedTransaction(),
                                    RemovedTransaction(),
                                  ]),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }))),
    );
  }
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
