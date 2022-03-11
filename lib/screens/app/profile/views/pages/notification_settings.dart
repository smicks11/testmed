import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/utils/colors.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool reminders = false;
    bool newOffers = false;
    bool feedbackReviews = false;
    bool updates = false;

    Widget platformSwitch(bool val) {
      return CupertinoSwitch(
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        value: val,
        activeColor: kPrimaryColor,
      );
    }

    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: size.height * 0.02),
              const Align(
                alignment: Alignment.topCenter,
                child: CText(
                  text: "Settings",
                  fontWeight: FontWeight.w700,
                  size: 15,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: CText(
                  text: 'Notifications',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  size: 18.0,
                ),
              ),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        const CText(
                          text: 'Reminders',
                          fontWeight: FontWeight.w700,
                          size: 15,
                          letterSpacing: 1,
                        ),
                        const Spacer(),
                        platformSwitch(reminders)
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        const CText(
                          text: 'New Offers',
                          fontWeight: FontWeight.w700,
                          size: 15,
                          letterSpacing: 1,
                        ),
                        const Spacer(),
                        platformSwitch(newOffers)
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        const CText(
                          text: 'Feedbacks and Reviews',
                          fontWeight: FontWeight.w700,
                          size: 15,
                          letterSpacing: 1,
                        ),
                        const Spacer(),
                        platformSwitch(feedbackReviews)
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        const CText(
                          text: 'Updates',
                          fontWeight: FontWeight.w700,
                          size: 15,
                          letterSpacing: 1,
                        ),
                        const Spacer(),
                        platformSwitch(updates)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
