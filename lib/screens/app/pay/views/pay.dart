import 'package:flutter/material.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/constants/image_assets.dart';
import 'package:medfest/utils/colors.dart';
import 'package:medfest/utils/size_config.dart';

import 'components/grid_board.dart';

class Pay extends StatefulWidget {
  const Pay({Key? key}) : super(key: key);

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.only(top: size.height * 0.18),
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(curveRadius),
                topRight: Radius.circular(curveRadius),
              ),
              color: kBackgroundColor,
            ),
            child: Column(
              children: [
                GridDashboard(),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.08),
                child: Column(
                  children: [
                    const CText(
                      text: 'Payments',
                      fontWeight: FontWeight.w600,
                      size: 26,
                      letterSpacing: 1.0,
                      color: kWhiteColor,
                    ),
                    SizedBox(height: size.height * 0.01),
                    const CText(
                      text: 'Handle all your MEDFESTCARE payments here',
                      fontWeight: FontWeight.w400,
                      size: 15,
                      letterSpacing: 1.0,
                      color: kWhiteColor,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
