import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:medfest/utils/colors.dart';

import 'home/views/home.dart';
import 'map/views/map_view.dart';
import 'medical/views/medical.dart';
import 'pay/views/pay.dart';
import 'profile/views/profile.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    MapView(),
    // Pay(),
    Medicals(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: kWhiteColor,
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kDarkGreyColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            enableFeedback: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Octicons.home),
                label: 'Calls',
              ),
              BottomNavigationBarItem(
                icon: Icon(Entypo.compass),
                label: 'Camera',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Entypo.creative_commons_noncommercial_eu),
              //   label: 'Chats',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Octicons.pulse),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Octicons.person),
                label: 'Chats',
              ),
            ],
          ),
        ),

        // bottomNavigationBar: SnakeNavigationBar.color(
        //   // height: 80,
        //   behaviour: SnakeBarBehaviour.pinned,
        //   snakeShape: SnakeShape.indicator,
        //   shape: null,
        //   padding: EdgeInsets.zero,

        //   ///configuration for SnakeNavigationBar.color
        //   snakeViewColor: selectedColor,
        //   selectedItemColor: selectedColor,
        //   unselectedItemColor: Colors.blueGrey,

        //   showUnselectedLabels: true,
        //   showSelectedLabels: showSelectedLabels,

        //   currentIndex: _selectedIndex,
        //   onTap: (index) => setState(() => _selectedIndex = index),
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
        //     BottomNavigationBarItem(icon: Icon(Entypo.compass), label: 'Map'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Entypo.creative_commons_noncommercial_eu),
        //         label: 'Pay'),
        //     BottomNavigationBarItem(icon: Icon(Octicons.pulse), label: 'Medical'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Octicons.person), label: 'Profile'),
        //   ],
        //   selectedLabelStyle: const TextStyle(fontSize: 14),
        //   unselectedLabelStyle: const TextStyle(fontSize: 10),
        // ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
