import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/auth/controller/auth_controller.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/button.dart';
import '../../../utils/colors.dart';
import '../../../utils/fields.dart';
import 'login_signup.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class NameScreen extends ConsumerWidget {
  final String age;
  final String gender;
  final TextEditingController name = TextEditingController();
  NameScreen({super.key, required this.age, required this.gender});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingStateProvider);

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 20,
        ),
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSizedBox(30.0),
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
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  heightSizedBox(10.0),
                  TxtField(
                    contentPadding: contentPadding,
                    controller: name,
                    keyboardType: TextInputType.name,
                    validator: validateName,
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
                  const Spacer(),
                  Btn(
                    text: "Continue",
                    onPressed: isLoading
                        ? () {}
                        : () {
                            if (formKey.currentState!.validate()) {
                              ref.read(loadingStateProvider.notifier).state =
                                  true;

                              ref
                                  .read(authControllerProvider)
                                  .createProfileController(
                                      age: age, gender: gender, name: name.text)
                                  .then(
                                (_) {
                                  ref
                                      .read(loadingStateProvider.notifier)
                                      .state = false;

                                  // navigationPush(context, const BottomBar());
                                },
                              );
                            }
                          },
                  )
                ],
              ),
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
