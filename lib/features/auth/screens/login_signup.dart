import 'package:flutter/material.dart';
import 'package:rush/features/auth/screens/otp_screen.dart';
import 'package:rush/utils/button.dart';
import 'package:rush/utils/fields.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/sizes.dart';

import '../../../utils/colors.dart';

class LoginSignup extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Login or\nSignup",
                style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w700),
              ),
              heightSizedBox(2.0),
              const Text(
                "We will send an SMS to verify",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500),
              ),
              heightSizedBox(15.0),
              Row(
                children: [
                  widthSizedBox(10.0),
                  const Text(
                    "Enter Phone",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              heightSizedBox(5.0),
              TxtField(
                contentPadding: contentPadding,
                controller: phone,
                keyboardType: TextInputType.phone,
              ),
              const Spacer(),
              Btn(
                  text: "Continue",
                  onPressed: () {

                    navigationPush(context,  OtpScreen(
                      mobile: phone.text,
                    ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
