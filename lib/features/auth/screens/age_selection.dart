import 'package:flutter/material.dart';
import 'package:rush/features/auth/screens/name.dart';
import 'package:rush/utils/button.dart';
import 'package:rush/utils/navigation.dart';
import '../../../utils/colors.dart';
import '../../../utils/sizes.dart';
import '../scr/age_dropdawn.dart';

class AgeScreen extends StatelessWidget {
  final String gender;
  const AgeScreen({super.key, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select your\nAge Range ",
              style: TextStyle(
                  fontSize: 40,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700),
            ),
            heightSizedBox(20.0),
            const AgeSelectionDropdown(),
            const Spacer(),
            Btn(
              text: "Continue",
              onPressed: () {
                navigationPush(context, NameScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}
