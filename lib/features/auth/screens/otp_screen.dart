import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:rush/features/auth/controller/auth_controller.dart';
import 'package:rush/features/auth/screens/login_signup.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/utils/message.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/button.dart';

class OtpScreen extends ConsumerWidget {
  final String mobile;

  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  OtpScreen({super.key, required this.mobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

      final isLoading = ref.watch(loadingStateProvider);
    // log("mobile=> $mobile");
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
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
                    "Enter 6 digit\ncode we have\nsent you ",
                    style: TextStyle(
                        fontSize: 40,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700),
                  ),
                  heightSizedBox(10.0),
                  Row(
                    children: [
                      Text(
                        "Code sent to $mobile",
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          navigationPop(context);
                        },
                        child: const Text(
                          "Edit number",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff534ff8),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  heightSizedBox(15.0),
                  OtpField(
                    otp: otpController,
                  ),
                  heightSizedBox(20.0),
                  const Row(
                    children: [
                      Text(
                        "Haven't received the OTP ?",
                        style: TextStyle(
                            fontSize: 14,
                            // color: Color(0xff000000),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Resend it in 25 sec",
                        style: TextStyle(
                            fontSize: 12,
                            // color: Color(0xff000000),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Btn(
                    text: "Continue",
                    onPressed: () {
                      log("otp=>>>>>${otpController.text}");
            
                      if (otpController.text.isEmpty) {
                        ShowSnackBarMsg("Otp is required", color: Colors.red);
                      } else {

                        ref.read(loadingStateProvider.notifier).state==true;
                        ref.read(authControllerProvider).signInController(
                            mobile: mobile, otp: otpController.text);
                      }
                    },
                  )
                ],
              ),
            ),
             if (isLoading) // Show circular progress indicator if loading
             const  Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

// class OtpField extends StatelessWidget {

//   const OtpField({super.key, required this.otp, });

//   final TextEditingController otp;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       width: width(context),
//       child: Container(
//         decoration: const BoxDecoration(),
//         child: Pinput(
//           // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//           // validator: validator != null ? (value) => validator!(value) : null,
//           defaultPinTheme: PinTheme(
//             width: 56,
//             height: 56,
//             textStyle: const TextStyle(
//                 fontSize: 20,
//                 color: Color.fromRGBO(30, 60, 87, 1),
//                 fontWeight: FontWeight.w600),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black12),
//               borderRadius: BorderRadius.circular(11),
//             ),
//           ),
//           length: 6,
//           showCursor: true,
//           controller: otp,
//         ),
//       ),
//     );
//   }
// }

class OtpField extends StatelessWidget {
  const OtpField({
    super.key,
    required this.otp,
    this.validator,
  });

  final TextEditingController otp;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width(context),
      child: Container(
        decoration: const BoxDecoration(),
        child: Pinput(
          defaultPinTheme: PinTheme(
            width: 56,
            height: 56,
            textStyle: const TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(30, 60, 87, 1),
              fontWeight: FontWeight.w600,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(11),
            ),
          ),
          length: 6,
          showCursor: true,
          controller: otp,
          // Pass the validator function to the validator property
          validator: validator,
        ),
      ),
    );
  }
}
