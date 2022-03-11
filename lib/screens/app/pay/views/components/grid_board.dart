import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/pay/views/components/donate_dialog.dart';
import 'package:medfest/screens/app/pay/views/pages/subscriptions.dart';
import 'package:medfest/screens/app/pay/views/pages/withdraw.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'fund_modal.dart';
import '../pages/transfer.dart';

// ignore: must_be_immutable
class GridDashboard extends StatelessWidget {
  GridDashboard({Key? key}) : super(key: key);
  Items item1 = Items(
      title: "Fund",
      subtitle: "Add Funds to your wallet",
      event: "",
      img: fund);

  Items item2 = Items(
    title: "Withdraw",
    subtitle: "Pull out funds to your local bank",
    event: "",
    img: withdraw,
  );
  Items item3 = Items(
    title: "Subscriptions",
    subtitle: "Create your health care retainer",
    event: "",
    img: subscribe,
  );
  Items item6 = Items(
    title: "Offers",
    subtitle: "Access more suggestions",
    event: "",
    img: expand,
  );
  Items item4 = Items(
    title: "Pay Bills",
    subtitle: "pay your medical bills",
    event: "",
    img: subscription,
  );
  Items item5 = Items(
    title: "Donate",
    subtitle: "Donate to MEDFESTCARE",
    event: "",
    img: fund,
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    // var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: () {
                if (data.title == "Fund") {
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
                      height: MediaQuery.of(context).size.height * 0.70,
                      child: const FundWallet(),
                    ),
                  );
                } else if (data.title == "Pay Bill") {
                  Get.to(() => const Transfer());
                } else if (data.title == "Donate") {
                  showModal(
                      configuration: const FadeScaleTransitionConfiguration(
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                      context: context,
                      builder: (_) {
                        return const DonateDialog();  
                      });
                } else if (data.title == "Withdraw") {
                  Get.to(() => Withdraw());
                } else if (data.title == "Subscriptions") {
                  Get.to(() => const Subscriptions());
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 2,
                        spreadRadius: 5,
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CText(
                        text: data.title,
                        color: Colors.black,
                        size: 16,
                        fontWeight: FontWeight.w600),
                    const SizedBox(
                      height: 8,
                    ),
                    CText(
                        text: data.subtitle,
                        color: Colors.black,
                        size: 10,
                        fontWeight: FontWeight.w600),
                    const SizedBox(
                      height: 14,
                    ),
                    CText(
                      text: data.event,
                      color: Colors.black,
                      size: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img});
}
