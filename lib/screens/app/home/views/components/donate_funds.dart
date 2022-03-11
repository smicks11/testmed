import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/screens/app/pay/views/components/donate_dialog.dart';
import 'package:medfest/utils/colors.dart';

class DonateFunds extends StatelessWidget {
  const DonateFunds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
          height: size.height,
          width: size.width,
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                const SizedBox(height: 20),
                  Container(
                  child: Lottie.asset(
                    'assets/lottie/lf30_editor_zr4meqkf.json',
                    height: 200.0,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                ),
                // SvgPicture.asset(donate, height: 300),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CText(
                    text: "We need your help ",
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    size: 25,
                    color: kPrimaryColor,
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CText(
                    text:
                        "Medfestcare wallet allows for donations from the public to fully achieve the free health care goal.\n\nMEDFESTCARE celebrates the top 5 outstanding donors of the free health care program every year.\n\nBe among the first 5 donors and get the unique MEDFESTCARE philanthropic badge.\n\nHit the donate button today to save a life.",
                    fontWeight: FontWeight.normal,
                    size: 14,
                    color: Colors.black54,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height*0.12,),
                GestureDetector(
                  onTap: () {
                    showModal(
                        configuration: const FadeScaleTransitionConfiguration(
                          transitionDuration: Duration(milliseconds: 500),
                        ),
                        context: context,
                        builder: (_) {
                          return const DonateDialog();
                        });
                  },
                  child: Container(
                    height: size.height*0.07,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: CText(
                        text: "Donate Now",
                        // fontWeight: FontWeight.bold,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            );
          })),
    );
  }
}
