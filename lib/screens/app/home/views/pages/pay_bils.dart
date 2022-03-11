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
import '../components/pay_medical.dart';

class PayBills extends StatefulWidget {
  const PayBills({Key? key}) : super(key: key);

  @override
  _PayBillsState createState() => _PayBillsState();
}

class _PayBillsState extends State<PayBills>
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
                                Text("Pay Bills 💵",
                                    style: heading1(context).copyWith(
                                        fontSize: 30, color: black, fontWeight: FontWeight.bold)),
                                kTinyVerticalSpacing,
                                Text(
                                  "Make bill payment!",
                                  style: bodySmallText(context).copyWith(color: kTextFieldColor),
                                )
                              ],
                            ),
                            kLargeVerticalSpacing,
                            TabSelect(
                              firstTab: "Pay",
                              secondTab: "Transfer",
                              thirdTab: "Donate",
                              indicatorColor: white,
                              labelColor: kPrimaryColor,
                              bdgColor: kPrimaryColor,
                              tabController: _tabController,
                            ),
                            Expanded(
                              child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    PayMedicalFees(),
                                    TransferFunds(),
                                    DonateFunds(),
                                  ]),
                            ),
                            // Align(
                            //   child: Obx(
                            //     () => Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         GestureDetector(
                            //           onTap: () {
                            // homeController.showTransferView();
                            //           },
                            //           child: Container(
                            //             height: constraints.maxHeight * 0.04,
                            //             width: constraints.maxWidth * 0.25,
                            //             decoration: BoxDecoration(
                            //               color: homeController
                            //                           .isTransferSelected.value ==
                            //                       true
                            //                   ? kPrimaryColor
                            //                   : kPrimaryColor.withOpacity(0.3),
                            //               borderRadius:
                            //                   BorderRadius.circular(curveRadius),
                            //             ),
                            //             child: const Center(
                            //                 child: CText(
                            //               text: "Transfer",
                            //               color: kWhiteColor,
                            //             )),
                            //           ),
                            //         ),
                            //         const SizedBox(width: 20),
                            //         GestureDetector(
                            //           onTap: () {
                            //             homeController.showWithdrawView();
                            //           },
                            //           child: Container(
                            //             height: constraints.maxHeight * 0.04,
                            //             width: constraints.maxWidth * 0.25,
                            //             decoration: BoxDecoration(
                            //               color: homeController
                            //                           .isWithdrawSelected.value ==
                            //                       true
                            //                   ? kPrimaryColor
                            //                   : kPrimaryColor.withOpacity(0.3),
                            //               borderRadius:
                            //                   BorderRadius.circular(curveRadius),
                            //             ),
                            //             child: const Center(
                            //               child: CText(
                            //                 text: "Donate",
                            //                 color: kWhiteColor,
                            //               ),
                            //             ),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Obx(
                            //   () => Expanded(
                            //     child:
                            //         homeController.isTransferSelected.value ==
                            //                 true
                            //             ? const TransferFunds()
                            //             : const DonateFunds(),
                            //   ),
                            // ),
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
