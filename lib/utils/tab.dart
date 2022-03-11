import 'package:flutter/material.dart';
import 'package:medfest/utils/colors.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class TabSelect extends StatelessWidget {
  final String firstTab;
  final String secondTab;
  final String thirdTab;
  final Color bdgColor;
  final Color indicatorColor;
  final Color labelColor;
  final Color inactiveColor;
  final TabController? tabController;
  const TabSelect({
    Key? key,
    required this.firstTab,
    required this.secondTab,
    this.bdgColor = Colors.white,
    this.indicatorColor = kPrimaryColor,
    this.labelColor = Colors.white,
    this.inactiveColor = Colors.white,
    this.tabController, required this.thirdTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Center(
          child: Container(
              height: 50.0,
              margin: const EdgeInsets.symmetric(horizontal: 52),
              decoration: BoxDecoration(
                color: bdgColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TabBar(
                onTap: (index) {
                  tabController?.animateTo(
                    index,
                  );
                },
                controller: tabController,
                indicator: BubbleTabIndicator(
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    indicatorHeight: 40.0,
                    indicatorColor: indicatorColor),
                labelStyle: TextStyle(
                  fontSize: 12.0,
                ),
                labelColor: labelColor,
                unselectedLabelColor: inactiveColor,
                tabs: [Text(firstTab), Text(secondTab), Text(thirdTab)],
              )),
        ));
  }
}
