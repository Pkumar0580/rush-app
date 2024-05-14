import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';
import 'package:rush/utils/secure_storage%20copy.dart';

final authRepoProvider = Provider.autoDispose((ref) => AuthRepo(ref));

class AuthRepo {
  final AutoDisposeProviderRef<Object?> ref;

  AuthRepo(this.ref);
  sendOtp(String mobile) async {
    try {
      final response = await ApiMethod(url: ApiUrl.sendOtp)
          .postDioRequest(data: {"phone_number": mobile});
      // log("Send Otp Repo Response= $response");
      return response;
    } catch (error) {
      log("Send Otp Repo Error= $error");
    }
  }

  signIn({required String mobile, required String otp}) async {
    try {
      final response = await ApiMethod(url: ApiUrl.verifyOtp)
          .putDioRequest(data: {"phone_number": mobile, "otp": otp},);

      // log("SignIn Repo Response= $response");
      return response;
    } catch (err) {
      log("SignIn Repo Error= $err");
    }
  }

  creataProfile({
    required String age,
    required String gender,
    required String name,
  
  }) async {
    try {
      final token =
          await ref.watch(secureStoargeProvider).readData("authToken");

      FormData formData =
          FormData.fromMap({"age": age, "gender": gender, "name": name});
      final response = await ApiMethod(url: ApiUrl.createUser, token: token)
          .putDioFormData(data: formData);

      // log("Create Profile Response=> $response");
      return response;
    } catch (err) {
      log("creataProfile Repo Error= $err");
    }
  }
}
