import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';

import 'package:medfest/utils/colors.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class WalletAddress extends StatelessWidget {
  const WalletAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
      children: [
          Container(
            height: size.height,
            width: size.width,
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.only(top: size.height * 0.2),
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(curveRadius),
                topRight: Radius.circular(curveRadius),
              ),
              color: kWhiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PrettyQr(
                    //image: AssetImage('images/twitter.png'),
                    typeNumber: 3,
                    size: size.height*0.3,
                    data: 'e33ea762-77b3-4b39-a1e5-8a9a3943a0ff',
                    errorCorrectLevel: QrErrorCorrectLevel.M,
                    roundEdges: true,
                  ),
                  const SizedBox(height: 20),
                  const CText(
                    text: "e33ea762-77b3-4b39-a1e5-8a9a3943a0ff",
                    fontWeight: FontWeight.bold,
                    size: 18,
                    color: Colors.black54,
                    letterSpacing: 1.0,
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () async {
                      ClipboardData data = const ClipboardData(
                          text: 'e33ea762-77b3-4b39-a1e5-8a9a3943a0ff');
                      await Clipboard.setData(data);
                      log("copied");
                      cToast(msg: "Wallet Address Copied to clipboard",color: Colors.red);
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Copy ",
                            style: GoogleFonts.lora(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kTextColor,
                              letterSpacing: 1,
                            ),
                          ),
                          const WidgetSpan(
                            child: Icon(
                              Entypo.documents,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: " Wallet Address",
                            style: GoogleFonts.lora(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kTextColor,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: kWhiteColor,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.08),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    children: [
                      const CText(
                        text: 'Wallet Address',
                        fontWeight: FontWeight.w600,
                        size: 26,
                        letterSpacing: 1.0,
                        color: kWhiteColor,
                      ),
                      SizedBox(height: size.height * 0.03),
                      const CText(
                        text:
                            'Scan the QR code or enter the wallet address manually in the auth field in the correct format',
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        size: 12,
                        letterSpacing: 1.0,
                        color: kWhiteColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
      ],
    ),
        ));
  }
}
