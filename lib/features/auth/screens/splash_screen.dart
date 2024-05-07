import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/auth/screens/login_image.dart';
import 'package:rush/utils/bottom_bar.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/secure_storage%20copy.dart';
import 'package:rush/utils/sizes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      var token = ref.read(checkAuthorizeProvider);
      log("Splash Chack => $token");
      // navigationPush(context, const LoginImage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    ;
  }
}

final checkAuthorizeProvider = FutureProvider.autoDispose((ref) async {
  String isLogin = await ref.watch(secureStoargeProvider).readData('authToken');

  log("token=> $isLogin");

  log(isLogin.toString());
  if (isLogin.isNotEmpty) {
    navigateTo(const BottomBar());
  } else {
    navigateTo(const LoginImage());
  }
});
