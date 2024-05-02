import 'package:flutter/material.dart';
import 'package:rush/features/auth/screens/login_signup.dart';
import 'package:rush/utils/navigation.dart';
import '../../../utils/button.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/images/login_image.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 15,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Btn(
                  text: 'LOG IN OR SIGN UP',
                  onPressed: () {
                    navigationPush(context, LoginSignup());
                    // navigationPush(context, AgeScreen());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
