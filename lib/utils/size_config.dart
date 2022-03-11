import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late double titleSize;
  static late double fontSize;
  static late double mFontSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    titleSize = _mediaQueryData.size.width * 0.08;
    fontSize = _mediaQueryData.size.width * 0.04;
    mFontSize = _mediaQueryData.size.width * 0.06;
  }
}
