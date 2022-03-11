import 'package:flutter/material.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/utils/colors.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final bool? load;
  final Color? buttonColor;
  final Color? textColor;
  const ActionButton(
      {Key? key,
      required this.callback,
      required this.text,
      this.load = false,
      this.buttonColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 50,
        width: size.width,
        decoration: BoxDecoration(
          color: buttonColor ?? kPrimaryColor,
          borderRadius: BorderRadius.circular(curveRadius),
        ),
        child: Center(
          child: CText(
            text: text,
            size: 16,
            fontWeight: FontWeight.w500,
            color: textColor ?? kWhiteColor,
          ),
        ),
      ),
    );
  }
}
