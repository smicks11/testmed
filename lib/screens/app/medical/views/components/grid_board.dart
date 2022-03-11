import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/medical/controller/medical_controller.dart';
import 'package:medfest/screens/app/pay/views/components/donate_dialog.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';

import 'health_dialog.dart';

// ignore: must_be_immutable
class GridDashboard extends StatelessWidget {
  GridDashboard({Key? key}) : super(key: key);
  Items item1 = Items(
      title: "Maternity", subtitle: "Pregrant women", event: "", img: baby);

  Items item2 = Items(
    title: "Child",
    subtitle: "Children under 5 years",
    event: "",
    img: babyboy,
  );
  Items item3 = Items(
    title: "Senile",
    subtitle: "Old People",
    event: "",
    img: grandparents,
  );
  Items item4 = Items(
    title: "Others",
    subtitle: "Access More Categories",
    event: "",
    img: expand,
  );
  // Items item5 = Items(
  //   title: "To do",
  //   subtitle: "Homework, Design",
  //   event: "4 Items",
  //   img: "assets/todo.png",
  // );
  // Items item6 = Items(
  //   title: "Settings",
  //   subtitle: "",
  //   event: "2 Items",
  //   img: "assets/setting.png",
  // );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];
    var profileController = Get.find<ProfileController>();
    var medicalController = Get.find<MedicalController>();
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
                // log(profileController.userData.value.walletAddress);
                // log(data.title.toLowerCase());
                // showModal(
                //     configuration: const FadeScaleTransitionConfiguration(
                //         transitionDuration: Duration(milliseconds: 500)),
                //     context: context,
                //     builder: (_) {
                //       return FreeHealthCareDialog(
                //           assetName: data.img, title: data.title);
                //     });
                // medicalController.freeHealthCare(
                //     walletAddress:
                //         profileController.userData.value.walletAddress,
                //     type: data.title.toLowerCase());
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
                        fontWeight: FontWeight.w600),
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
