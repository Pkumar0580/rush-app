import 'package:flutter/material.dart';
import 'package:rush/utils/bottom_bar.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/button.dart';
import '../../../utils/colors.dart';
import '../../../utils/fields.dart';
import '../../../utils/navigation.dart';

class NameScreen extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  NameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 25,
          right: 25,
          bottom: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "By what name\nshould we call\nyou?",
                style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w700),
              ),
              heightSizedBox(20.0),
              const Text(
                "Tell us your full name",
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500),
              ),
              heightSizedBox(20.0),
              Row(
                children: [
                  widthSizedBox(10.0),
                  const Text(
                    "Enter Full name",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              heightSizedBox(10.0),
              TxtField(
                contentPadding: contentPadding,
                controller: name,
                keyboardType: TextInputType.name,
              ),
              heightSizedBox(20.0),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: const Text(
                    "Have a referral code ?",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff534ff8),
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Btn(
                text: "Continue",
                onPressed: () {
                  navigationPush(context, const BottomBar());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
