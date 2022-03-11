import 'package:flutter/material.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/screens/app/pay/views/components/subs_plans.dart';
import 'package:medfest/utils/colors.dart';

class Subscriptions extends StatelessWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: CText(
                  text: 'Start your Plan',
                  fontWeight: FontWeight.w600,
                  size: 26,
                  letterSpacing: 1.0,
                  color: kBlackColor,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: CText(
                  text: 'Try your free plan',
                  fontWeight: FontWeight.w400,
                  size: 16,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: size.height * 0.70,
                width: size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SubscriptionPlan(
                      height: size.height * 0.70,
                      width: size.width,
                      subscriptionType: "Basic",
                      subscriptionTypeSubtitle: "Healthy Subscriber",
                      price: "₦2,000",
                      a: false,
                      b: true,
                    ),
                    SubscriptionPlan(
                      height: size.height * 0.70,
                      width: size.width,
                      subscriptionType: "Premium",
                      subscriptionTypeSubtitle: " Very Healthy Subscriber",
                      price: "₦5,000",
                      a: false,
                      b: false,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.center,
                child: CText(
                  text:
                      'We offer long-term and short-term medical plans. Subscribe today and have access to our improved medical treatment via our trusted medical facilities ',
                  fontWeight: FontWeight.w400,
                  size: 16,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
