import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/auth/repo/auth_repo.dart';
import 'package:rush/features/auth/screens/gender_selection.dart';
import 'package:rush/features/auth/screens/otp_screen.dart';
import 'package:rush/features/profile/repo/profile_repo.dart';
import 'package:rush/utils/bottom_bar.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/secure_storage%20copy.dart';
import '../../../utils/message.dart';

final authControllerProvider = Provider.autoDispose((ref) {
  final authResp = ref.watch(authRepoProvider);
  return AuthController(ref: ref, authRepo: authResp);
});

class AuthController {
  AutoDisposeProviderRef<Object?> ref;
  final AuthRepo authRepo;
  AuthController({required this.ref, required this.authRepo});

  sendOtpController(String mobile) async {
    try {
      final res = await authRepo.sendOtp(mobile);
      if (res != null &&
          res["status"] != null &&
          res["status"]["code"] == 290) {
        ShowSnackBarMsg("Otp send is $mobile", color: Colors.green);
        navigateTo(OtpScreen(mobile: mobile));
      }
    } catch (error) {
      log("Send Otp Controller Eror=>$error");
    }
  }

  signInController({required String mobile, required String otp}) async {
    try {
      final res = await authRepo.signIn(mobile: mobile, otp: otp);
      if (res['already_registered'] == false) {
        navigateTo(const GenderScreen());
        ref
            .watch(secureStoargeProvider)
            .writeData(key: "authToken", value: "${res['token']}");
      } else {
        await ref
            .watch(secureStoargeProvider)
            .writeData(key: "authToken", value: "${res['token']}");

        ref.invalidate(isLoginProvider);
        navigateTo(const BottomBar());
      }
    } catch (error) {
      log("Send Otp Controller Eror=>$error");
    }
  }

  createProfileController(
      {required String age,
      required String gender,
      required String name}) async {
    try {
      final res =
          await authRepo.creataProfile(age: age, gender: gender, name: name);
      if (res == null) {
        ShowSnackBarMsg("Plese try again", color: Colors.green);
      } else {
        navigatePushReplacement(const BottomBar());
      }
      log("Create Profile Controller Response=> $res");
    } catch (error) {
      log("Create Profile Controller Eror=>$error");
    }
  }

  imageUpload(String image) async {}
}
