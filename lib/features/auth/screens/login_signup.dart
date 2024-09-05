import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/auth/controller/auth_controller.dart';
import 'package:rush/features/auth/screens/otp_screen.dart';
import 'package:rush/utils/button.dart';
import 'package:rush/utils/fields.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/colors.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

final loadingStateProvider = StateProvider<bool>((ref) => false);

class LoginSignup extends ConsumerWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final TextEditingController phone = TextEditingController();
  LoginSignup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingStateProvider);

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 20),
        child: Stack(
          children: [
            Form(
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
                  // heightSizedBox(15.0),
                  // Row(
                  //   children: [
                  //     widthSizedBox(10.0),
                  //     const Text(
                  //       "Enter Phone",
                  //       style: TextStyle(
                  //           fontSize: 13, fontWeight: FontWeight.w500),
                  //     ),
                  //   ],
                  // ),
                  heightSizedBox(15.0),
                  TxtField(
                      contentPadding: contentPadding,
                      controller: phone,
                      labelText: "Phone Number",
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      validator: validateMobile),
                  const Spacer(),
                  Btn(
                    text: "Continue",
                    onPressed: isLoading
                        ? () {}
                        : () {
                            if (formKey.currentState!.validate()) {
                              // if (phone.text == "9782209395") {
                              //   navigateTo(OtpScreen(mobile: "9782209395"));
                              // } else {}
                              ref.read(loadingStateProvider.notifier).state =
                                  true;

                              ref
                                  .read(authControllerProvider)
                                  .sendOtpController(phone.text)
                                  .then((_) {
                                ref.read(loadingStateProvider.notifier).state =
                                    false;
                              });
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










// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:rush/features/auth/controller/sendOtp_controller.dart';
// import 'package:rush/utils/button.dart';
// import 'package:rush/utils/fields.dart';
// import 'package:rush/utils/sizes.dart';
// import '../../../utils/colors.dart';

// class LoginSignup extends ConsumerWidget {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   TextEditingController phone = TextEditingController();
//   LoginSignup({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColor.backgroundColor,
//       ),
//       body: Padding(
//         padding:
//             const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 20),
//         child: Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Login or\nSignup",
//                 style: TextStyle(
//                     fontSize: 40,
//                     color: Color(0xff000000),
//                     fontWeight: FontWeight.w700),
//               ),
//               heightSizedBox(2.0),
//               const Text(
//                 "We will send an SMS to verify",
//                 style: TextStyle(
//                     fontSize: 16,
//                     color: Color(0xff000000),
//                     fontWeight: FontWeight.w500),
//               ),
//               heightSizedBox(15.0),
//               Row(
//                 children: [
//                   widthSizedBox(10.0),
//                   const Text(
//                     "Enter Phone",
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//               heightSizedBox(5.0),
//               TxtField(
//                 contentPadding: contentPadding,
//                 controller: phone,
//                 maxLength: 10,
//                 keyboardType: TextInputType.phone,
//               ),
//               const Spacer(),
//               Btn(
//                 text: "Continue",
//                 onPressed: () {
//                   log(" Phone=>${phone.text}");

//                   ref
//                       .read(authControllerProvider)
//                       .sendOtpController(phone.text);

//                   // navigationPush(
//                   //   context,
//                   //   OtpScreen(mobile: phone.text),
//                   // );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
