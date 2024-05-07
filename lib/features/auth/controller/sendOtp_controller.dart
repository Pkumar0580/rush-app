import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/auth/repo/auth_repo.dart';
import 'package:rush/features/auth/screens/gender_selection.dart';
import 'package:rush/features/auth/screens/otp_screen.dart';
import 'package:rush/utils/bottom_bar.dart';
import 'package:rush/utils/message.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/secure_storage%20copy.dart';

final authControllerProvider = Provider.autoDispose((ref) {
  final authResp = ref.watch(authRepoProvider);
  return AuthController(ref: ref, authRepo: authResp);
});

class AuthController {
  AutoDisposeProviderRef<Object?> ref;
  final AuthRepo authRepo;

  AuthController({
    required this.ref,
    required this.authRepo,
  });

  sendOtpController(String mobile) async {
    try {
      final context = navigatorKey.currentContext;
      final res = await authRepo.sendOtp(mobile);
      log("Mobile1=> $mobile");

      log("Send Otp Controller Response=> $res");
      log("Send Otp Controller Status=> ${res['status']}");

      if (res != null &&
          res["status"] != null &&
          res["status"]["code"] == 290) {
        navigateTo(OtpScreen(mobile: mobile));
        snackBarMsessege("Otp Send Successfully", color: Colors.green);
      }

      log("Send Otp Controller Response=> $res");
    } catch (error) {
      log("Send Otp Controller Eror=>$error");
    }
  }

  signInController({required String mobile, required String otp}) async {
    try {
      final res = await authRepo.signIn(mobile: mobile, otp: otp);
      // log("Mobile1=> $mobile");
      // log("otp=> $otp");

      if (res['already_registered'] == false) {
        navigateTo(const GenderScreen());
          ref
            .watch(secureStoargeProvider)
            .writeData(key: "authToken", value: "${res['token']}");
      } else {
        // log("Send Otp Controller Response=> ${res['token']}");

        navigateTo(const BottomBar());
        ref
            .watch(secureStoargeProvider)
            .writeData(key: "authToken", value: "${res['token']}");
      }
    } catch (error) {
      log("Send Otp Controller Eror=>$error");
    }
  }
}




//  sendOtpController(Map data) async {
//     try {
//       // final context = navigatorKey.currentContext;

//       final res = await authResp.sendOtpResp(data['mobile']);

//       if (res['success'] == 0) {
//         snackBarMsg(res['msg'] + " " + data['mobile'], color: Colors.green);
//         navigateTo(OtpScreen(data: data));
//       } else {
//         snackBarMsg(res['data']["msg"], color: Colors.red);
//       }
//     } catch (err) {
//       log("Error:Send Otp Controller:  $err");
//     }
//   }