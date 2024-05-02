import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:pinput/pinput.sl
import 'package:rush/features/auth/screens/gender_selection.dart';
import 'package:rush/utils/colors.dart';
import 'package:rush/utils/fields.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/sizes.dart';

import '../../../utils/button.dart';

class OtpScreen extends StatelessWidget {
  final String mobile;
  const OtpScreen({super.key, required this.mobile});

  @override
  Widget build(BuildContext context) {
    log("mobile=> $mobile");
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 20),
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

            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OtpField(),
                  OtpField(),
                  OtpField(),
                  OtpField(),
                  OtpField(),
                  OtpField(),
                ],
              ),
            ),

            // SizedBox(
            //   height: 50,
            //   width: width(context),
            //
            //
            //   // OTPTextField(
            //   //   length: 6,
            //   // ),
            //
            //   // child: PinInputExample()
            //
            //   child: const Pinput(
            //     length: 6,
            //     showCursor: true,
            //   ),
            // ),
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
                  navigationPush(context, const GenderScreen());
                  // navigationPush(context, ());
                })
          ],
        ),
      ),
    );
  }
}

class OtpField extends StatelessWidget {
  const OtpField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        onSaved: (newValue) {},
        decoration: InputDecoration(
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Set the border radius here
          ),
        ),
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}

// class PinInputExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final _pinController = TextEditingController();

//     return Pinput(
//       length: 6, // Number of PIN digits
//       obscureText: true, // Hides the entered PIN characters
//       controller:
//           _pinController, // Attach a TextEditingController for further manipulation
//       submittedPinTheme: PinTheme(
//         // Theme for the submitted PIN state
//         decoration: BoxDecoration(
//           border: Border.all(
//               color: Colors.green), // Change border color on submission
//         ),
//       ),
//       onCompleted: (pin) =>
//           print("Entered PIN: $pin"), // Callback on PIN completion
//     );
//   }
// }



// class OtpTextField extends StatelessWidget {
//   final int length; // Length of the OTP field (default: 6)
//   final Color borderColor; // Color of the outline border (default: Colors.grey)
//   final TextStyle? textStyle; // Style of the text (default: null)
//   final ValueChanged<String> onChanged; // Callback for value changes

//   const OtpTextField({
//     Key? key,
//     this.length = 6,
//     this.borderColor = Colors.grey,
//     this.textStyle,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: List.generate(length, (index) => _buildTextField(index)),
//     );
//   }

//   Widget _buildTextField(int index) {
//     return SizedBox(
//       width: 40,
//       height: 60,
//       child: TextField(
//         key: ValueKey(index),
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         textAlign: TextAlign.center,
//         decoration: InputDecoration(
//           counterText: "", // Hide the default counter
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide(color: borderColor),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide(color: borderColor),
//           ),
//         ),
//         style: textStyle ?? const TextStyle(fontSize: 16.0), // Default text style
//         onChanged: (value) {
//           if (value.length == 1) {
//             FocusScope.of(context).nextFocus(); // Move focus to next field
//           }
//           onChanged(value); // Pass the updated value to the callback
//         },
//       ),
//     );
//   }
// }


