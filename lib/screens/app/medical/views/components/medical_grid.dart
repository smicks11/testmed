import 'dart:convert';
import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medfest/API/api.dart';
import 'package:medfest/Provider/freehealthcareprovider.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/medical/controller/medical_controller.dart';
import 'package:medfest/screens/app/medical/views/components/health_dialog.dart';
import 'package:medfest/screens/app/profile/controller/profile_controller.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MedicalGrid extends StatelessWidget {
  final double width;
  final double height;

  MedicalGrid({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    var medicalController = Get.find<MedicalController>();
    return Consumer<FreeHealthCareProvider>(
        builder: (context, freehealcareprovider, widget) {
      return FutureBuilder<dynamic>(
          future: freehealcareprovider.memoizer
              .runOnce(() => API().getReq("myfreehealthcare")),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              var response = snapshot.data;
              if (response != null) {
                if (response.statusCode == 200) {
                  var data = jsonDecode(response.body);
                  var freehealthcares = List.from(data);
                  return SizedBox(
                      height: height,
                      width: width,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: item(
                                      height: constraints.maxHeight * 0.46,
                                      assetName: child,
                                      color: const Color(0xFFFFEAE9),
                                      title: "Child",
                                      subtitle: "",
                                      amount:
                                          freehealthcares[0]["amount"].toString(),
                                      callback: () {
                                        showModal(
                                            configuration:
                                                const FadeScaleTransitionConfiguration(
                                                    transitionDuration: Duration(
                                                        milliseconds: 500)),
                                            context: context,
                                            builder: (_) {
                                              return FreeHealthCareDialog(
                                                  availablebalance:
                                                      freehealthcares[0]
                                                          ["amount"],
                                                  assetName: child,
                                                  title: "Child");
                                            });
                                      },
                                    ),
                                  ),
                                  kSmallHorizontalSpacing,
                                  Expanded(
                                    child: item(
                                      height: constraints.maxHeight * 0.46,
                                      assetName: pregnant,
                                      color: const Color(0xFFE3EDFF),
                                      title: "Maternity",
                                      subtitle: "",
                                      amount:
                                          freehealthcares[1]["amount"].toString(),
                                      callback: () {
                                        showModal(
                                            configuration:
                                                const FadeScaleTransitionConfiguration(
                                                    transitionDuration: Duration(
                                                        milliseconds: 500)),
                                            context: context,
                                            builder: (_) {
                                              return FreeHealthCareDialog(
                                                  availablebalance:
                                                      freehealthcares[1]
                                                          ["amount"],
                                                  assetName: pregnant,
                                                  title: "Maternity");
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              const SizedBox(height: 20),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: item(
                                      height: constraints.maxHeight * 0.46,
                                      assetName: old,
                                      color: const Color(0xFFEDE4FF),
                                      title: "Senile",
                                      subtitle: "",
                                      amount: freehealthcares[2]["amount"]
                                          .toString(),
                                      callback: () {
                                        showModal(
                                            configuration:
                                                const FadeScaleTransitionConfiguration(
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds: 500)),
                                            context: context,
                                            builder: (_) {
                                              return FreeHealthCareDialog(
                                                  availablebalance:
                                                      freehealthcares[2]
                                                          ["amount"],
                                                  assetName: old,
                                                  title: "Senile");
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ));
                } else {
                  return cToast(msg: response.body, color: Colors.red);
                }
              } else {
                return Center(
                    child: Container(
                  height: height * 0.3,
                  width: width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          "Unable to establish connection",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            freehealcareprovider.refresh();
                          },
                          child: const Text(
                            "Refresh",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),
                ));
              }
            } else if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasData) {
              return Center(
                  child: Container(
                height: height * 0.3,
                width: width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Text(
                        "Unable to establish connection",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          freehealcareprovider.refresh();
                        },
                        child: const Text(
                          "Refresh",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                  ],
                ),
              ));
            } else {
              return SpinKitFadingCircle(
                color: kPrimaryColor,
                size: height * 0.1,
              );
            }
          });
    });
  }

  Widget item({
    required double height,
    required String assetName,
    required Color color,
    required String title,
    required String subtitle,
    required String amount,
    VoidCallback? callback,
  }) =>
      GestureDetector(
        onTap: callback,
        child: Container(
          height: height,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  assetName,
                  height: height * 0.5,
                ),
              ),
              CText(
                text: title,
                size: 24,
                color: kTextColor,
                fontWeight: FontWeight.w400,
              ),
              CText(
                text: subtitle,
                size: 18,
                color: kTextColor,
                fontWeight: FontWeight.w400,
              ),
              Text(
                "₦ $amount",
                style: const TextStyle(
                    color: kTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      );
}
