import 'package:flutter/material.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/utils/colors.dart';

class SubscriptionPlan extends StatelessWidget {
  final double height;
  final double width;
  final String subscriptionType;
  final String subscriptionTypeSubtitle;
  final String price;
  final bool a;
  final bool b;
  const SubscriptionPlan({
    Key? key,
    required this.height,
    required this.width,
    required this.subscriptionType,
    required this.subscriptionTypeSubtitle,
    required this.price,
    required this.a,
    required this.b,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.8,
      width: width * 0.8,
      margin: const EdgeInsets.only(right: 20, bottom: 5),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(curveRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            spreadRadius: 4,
            blurRadius: 2,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CText(
                  text: subscriptionType,
                  fontWeight: FontWeight.w600,
                  size: 26,
                  letterSpacing: 1.0,
                  color: kBlackColor,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CText(
                  text: subscriptionTypeSubtitle,
                  fontWeight: FontWeight.w400,
                  size: 16,
                  letterSpacing: 1.0,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CText(
                  text: price,
                  fontWeight: FontWeight.w700,
                  size: 33,
                  letterSpacing: 1.0,
                  color: kBlackColor,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: constraints.maxHeight * 0.1,
                width: constraints.maxWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(curveRadius),
                  border: Border.all(
                    color: kPrimaryColor,
                  ),
                ),
                child: const Center(
                  child: CText(
                    text: "Purchase now",
                    fontWeight: FontWeight.w600,
                    size: 20,
                    letterSpacing: 1.0,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              item(text: "Annual Payment", fade1: a, fade2: b, index: 1),
              item(text: "Free Medical Access", fade1: a, fade2: b, index: 1),
              item(
                  text: "Increased Referral points",
                  fade1: a,
                  fade2: b,
                  index: 2),
              item(text: "Ambulance Access ", fade1: a, fade2: b, index: 2),
            ],
          );
        },
      ),
    );
  }

  Widget item(
          {required String text,
          required bool fade1,
          required bool fade2,
          required int index}) =>
      Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 10,
              child: Center(
                child: Icon(
                  Icons.done,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(width: 20),
            CText(
              text: text,
              fontWeight: FontWeight.w400,
              size: 16,
              letterSpacing: 1.0,
              color: index == 1 && fade1 == false
                  ? kTextColor
                  : index == 2 && fade2 == false
                      ? kTextColor
                      : index == 3 && fade2 == false
                          ? kTextColor
                          : kTextColor.withOpacity(0.4),
            ),
          ],
        ),
      );
}
