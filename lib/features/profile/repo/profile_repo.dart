import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';
import 'package:rush/utils/secure_storage%20copy.dart';

import '../../../utils/message.dart';
import '../../../utils/navigation.dart';
import '../../auth/screens/login_signup.dart';

final profileRepoProvider = Provider.autoDispose((ref) => ProfileRepo(ref));
final isLoginProvider = StateProvider<String>((ref) => "");

class ProfileRepo {
  final AutoDisposeProviderRef<Object?> ref;

  ProfileRepo(this.ref);
  Future getProfile() async {
    try {
      final token =
          await ref.watch(secureStoargeProvider).readData('authToken');

      final response =
          await ApiMethod(url: ApiUrl.getUser, token: token).getDioRequest();

      return response;
    } on DioException catch (err) {
      if (Platform.isIOS && err.response!.data['error'] == "Unauthorized") {
        ref.read(isLoginProvider.notifier).state = err.response!.data['error'];
        showAlertDialog(
          "Offer Grab",
          "If you want to grab the deal, you need to log in first.",
          onOkPressed: () {
            navigateTo(LoginSignup());
          },
        );
      } else {
        ShowSnackBarMsg("${err.response!.data['error']}", color: Colors.red);
      }
    }
  }

  Future editProfile() async {
    try {
      final token =
          await ref.watch(secureStoargeProvider).readData('authToken');

      final response =
          await ApiMethod(url: ApiUrl.getUser, token: token).putDioRequest();

      return response;
    } catch (err) {
      log("Profile Repo Error=> $err");
    }
  }

  Future imageUpload({required File image}) async {
    log("Image Repo=================> ${image.path}");

    try {
      FormData formData = FormData.fromMap({
        "profile_pic": await MultipartFile.fromFile(
          image.path,
        ),
      });
      final token =
          await ref.watch(secureStoargeProvider).readData("authToken");

      final response = ApiMethod(url: ApiUrl.createUser, token: token)
          .putDioFormData(data: formData);
      return response;
    } catch (err) {
      log("Image Upload Error=> $err");
    }
  }
}



// final response = await ApiMethod(url: "${ApiUrl.getUser}${id}").getDioRequest();