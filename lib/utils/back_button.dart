// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.all(kPad),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            // height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.1,
                color: black
              ),
              borderRadius: BorderRadius.circular(kPad / 4)
            ),
            child: Icon(Icons.arrow_back, size: 16, color: kWhiteColor,),
          ),
        ),
      ),
    );
  }
}