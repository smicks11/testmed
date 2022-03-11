import 'package:flutter/material.dart';
import 'package:medfest/utils/colors.dart';

class CText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final double? wordSpacing;
  final VoidCallback? onClick;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final bool? bold;

  const CText(
      {Key? key,
      required this.text,
      this.size,
      this.fontWeight,
      this.color,
      this.wordSpacing,
      this.onClick,
      this.letterSpacing,
      this.bold = false,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: onClick == null
          ? Text(
              text,
              textAlign: textAlign ?? TextAlign.center,
              style: TextStyle(
                fontSize: size ?? 16,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: color ?? kTextFieldColor,
                wordSpacing: wordSpacing,
                letterSpacing: letterSpacing ?? 0,
                // fontFamily: bold == true ? "Booing" : "Graphik",
              ),
            )
          : TextButton(
              onPressed: () => onClick?.call(),
              child: Text(
                text,
                textAlign: textAlign ?? TextAlign.center,
                style: TextStyle(
                  fontSize: size ?? 16,
                  fontWeight: fontWeight ?? FontWeight.w500,
                  color: color ?? kTextFieldColor,
                  wordSpacing: wordSpacing,
                  // fontFamily: bold == true ? "Booing" : "Graphik",
                ),
              ),
            ),
    );
  }
}
