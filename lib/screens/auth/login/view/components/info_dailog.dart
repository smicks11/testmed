import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medfest/components/text.dart';
import 'package:lottie/lottie.dart';
import 'package:medfest/utils/colors.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const CText(
        text: "Yay! 🎉 Welcome to MEDFESTCARE",
        size: 20,
        fontWeight: FontWeight.w500,
        color: black,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
                  child: Lottie.asset(
                    'assets/lottie/4746-welcome-screen.json',
                    height: 200.0,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                ),
          // SvgPicture.asset(
          //   love,
          //   height: 300,
          // ),
          const SizedBox(height: 10),
          const CText(
              text:
                  "Bear these features in mind while choosing an animation \n1. Helps users Locate medical facilities around them i.e hospital, pharmacy, diagnostic centres\n2. Helps users save money in their wallet per time (i.e monthly, weekly...)for future health care needs \n3. Helps healthcare facilities boost their business cos they can be easily found and their services easily paid for\n 4. Helps users access free healthcare\n5. Gives the public the opportunity to help those who don't have money to take care of their health by donating to the free healthcare cause")
        ],
      ),
    );
  }
}
