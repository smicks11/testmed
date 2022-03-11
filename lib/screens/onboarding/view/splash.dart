import 'package:flutter/material.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(splashbg),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                //SizedBox(height:)

                Align(
                  alignment: Alignment.center,
                  child: CText(
                    text: "MEDFESTCARE",
                    size: 30,
                    color: kWhiteColor,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
