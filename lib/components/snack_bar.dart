import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:medfest/utils/colors.dart';

cToast({required String msg,required Color color}) => Get.snackbar(
      "Notice!",
      msg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
      icon: const Icon(Entypo.info_with_circle, color: kWhiteColor),
      shouldIconPulse: true,
      colorText: kWhiteColor,
      margin: const EdgeInsets.all(15),
      duration: const Duration(seconds: 4),
      isDismissible: true,
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
    );
