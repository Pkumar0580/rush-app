import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/auth/screens/login_signup.dart';
import 'package:rush/utils/api_method.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/secure_storage%20copy.dart';

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
      // if (Platform.isIOS && err.response!.data['error'] == "Unauthorized") {
      //   ref.invalidate(isLoginProvider);
      //   navigateTo(LoginSignupIOS());
      // }
      ref.read(isLoginProvider.notifier).state = err.response!.data['error'];
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