import 'package:flutter/material.dart';
import 'package:rush/features/brand/screens/my_brand.dart';
import 'package:rush/features/offer/screens/myoffer_screen.dart';
import 'package:rush/features/profile/screens/profile_screen.dart';

import '../features/home/screens/home_screen.dart';
import 'colors.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var pages = [
    const HomeScreen(),
    const MyOfferScreen(),
    const MyBrandScreen(),
     ProfileScreen()
  ];
  int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: pages[selectedItem],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColor.btnColor,
        iconSize: 22.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        unselectedItemColor: AppColor.primaryColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'MY OFFERS',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.branding_watermark,
            ),
            label: 'MY BRANDS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedItem,
        onTap: (value) {
          setState(
            () {
              selectedItem = value;
            },
          );
        },
      ),
    );
  }
}
