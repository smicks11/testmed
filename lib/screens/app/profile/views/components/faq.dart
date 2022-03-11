import 'package:flutter/material.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/utils/colors.dart';

class FAQ extends StatelessWidget {
  FAQ({Key? key}) : super(key: key);
  final List<Panel> panels = [
    Panel(
        'HOW CAN I CHANGE MY TRANSACTION PIN?',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio.',
        false),
    Panel(
        'HOW CAN I FUND MY WALLET?',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio.',
        false),
    Panel(
        'HOW CAN I WITHDRAW?',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio.',
        false),
    Panel(
        'HOW CAN I MAKE SUBSCRIBE?',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio.',
        false),
    Panel(
        'HOW MANY ACTIVE SUBSCRIPTIONS CAN I MAKE AT A TIME',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio.',
        false),
    Panel(
        'HOW CAN I GET FREE HEALTH CARE',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio.',
        false),
    Panel(
        'HOW LONG WILL IT TAKE BEFORE I GET CREDITTED AFTER I WITHDRAW?',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio.',
        false),
    Panel(
        'HOW DO I DELETE MY ACCOUNT?',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio.',
        false),
    Panel(
        'HOW DO I MAKE PAYMENTS FOR MY BILLS? HOW DOES IT WORK?',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborumnumquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentiumoptio.',
        false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Image.asset(settings),
                    const CText(
                      text: "Frequently Asked Questions",
                      fontWeight: FontWeight.w700,
                      size: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
                child: CText(
                    text: 'Review of our FAQ',

                    // color: Colors.black,
                    fontWeight: FontWeight.w700,
                    size: 18.0),
              ),
              ...panels
                  .map(
                    (panel) => ExpansionTile(
                      iconColor: kPrimaryColor,
                      title: CText(
                          text: panel.title,
                          size: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          color: const Color(0xffFAF1E2),
                          child: CText(
                              text: panel.content,
                              color: Colors.grey,
                              size: 12),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class Panel {
  String title;
  String content;
  bool expanded;

  Panel(this.title, this.content, this.expanded);
}
