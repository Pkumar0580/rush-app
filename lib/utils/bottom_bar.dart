import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/auth/screens/login_signup.dart';
import 'package:rush/features/brand/screens/brands.dart';
import 'package:rush/features/offer/screens/offers_screen.dart';
import 'package:rush/features/profile/repo/profile_repo.dart';
import 'package:rush/features/profile/screens/profile_screen.dart';
import 'package:rush/utils/secure_storage%20copy.dart';
import '../features/home/screens/home_screen.dart';
import 'colors.dart';

final getTokenProvider = FutureProvider.autoDispose((ref) async {
  final token = await ref.watch(secureStoargeProvider).readData("authToken");

  return token;
});

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    final isLogin = ref.watch(isLoginProvider);

    var pages = [
      HomeScreen(),
      const OffersScreen(),
      const BrandScreen(),
      Platform.isIOS&&isLogin=="Unauthorized"?LoginSignup():
      ProfileScreen()
    ];
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
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
              icon: Icon(Icons.home_outlined),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'OFFERS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.branding_watermark),
              label: 'BRANDS',
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
      ),
    );
  }
}
