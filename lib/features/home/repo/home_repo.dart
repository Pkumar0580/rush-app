
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';

import '../../../utils/message.dart';
import '../../../utils/secure_storage copy.dart';

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
      ShowSnackBarMsg("${e.response!.data['error']}", color: Colors.red);
    }
  }
}
