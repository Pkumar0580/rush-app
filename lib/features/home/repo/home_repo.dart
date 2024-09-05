import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';

import '../../../utils/message.dart';
import '../../../utils/navigation.dart';
import '../../../utils/secure_storage copy.dart';
import '../../auth/screens/login_signup.dart';

final homeRepoProvider = Provider.autoDispose((ref) => HomeRepo(ref));

class HomeRepo {
  final AutoDisposeProviderRef<Object?> ref;

  HomeRepo(this.ref);

  Future postRating({required double rating, required String comment}) async {
    try {
      final token =
          await ref.watch(secureStoargeProvider).readData('authToken');
      final res = await ApiMethod(url: ApiUrl.rating, token: token)
          .postDioRequest(data: {'rating': rating, "comment": comment});
      ShowSnackBarMsg("${res['message']}", color: Colors.green);
      return res;
    } on DioException catch (e) {
      if (Platform.isIOS && e.response!.data['error'] == "Unauthorized") {
        showAlertDialog(
          "Rate Us",
          "If you want to rate this app, you need to log in first.",
          onOkPressed: () {
            navigateTo(LoginSignup());
          },
        );
      } else {
        ShowSnackBarMsg("${e.response!.data['error']}", color: Colors.red);
      }
    }
  }
}
