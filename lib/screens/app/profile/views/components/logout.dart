import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/utils/colors.dart';

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.center,
          child: CText(
            text: "Logout?",
            color: black,
            size: 24,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.center,
          child: CText(
            text: "Are you sure you want to logout?",
            // color: black,
            size: 18,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 164,
                height: 56,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: CText(
                    text: "No",
                    size: 18,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 164,
                height: 56,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: CText(
                    text: "Yes",
                    size: 18,
                    fontWeight: FontWeight.w600,
                    color: white,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
