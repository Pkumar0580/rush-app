import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/utils/api_method.dart';
import 'package:rush/utils/message.dart';
import 'package:rush/utils/secure_storage.dart';

final OffersRepoProvider = Provider.autoDispose((ref) => OffersRepo(ref));

class OffersRepo {
  final AutoDisposeProviderRef<Object?> ref;

  OffersRepo(this.ref);
  Future getOffers() async {
    try {
      final response = await ApiMethod(url: ApiUrl.getOffers).getDioRequest();
      return response;
    } catch (e) {
      log("Get Offer Error=> $e");
    }
  }

  Future getHomeOffers() async {
    try {
      final response =
          await ApiMethod(url: ApiUrl.getHomeOffers).getDioRequest();
      return response;
    } catch (e) {
      log("Get Offer Error=> $e");
    }
  }

  Future getSavedOffers() async {
    try {
      final token =
          await ref.watch(secureStoargeProvider).readData('authToken');
      final response = await ApiMethod(url: ApiUrl.getSavedOffers, token: token)
          .getDioRequest();
      return response;
    } catch (e) {
      log("Get Offer Error=> $e");
    }
  }

  Future getOffersById({required String id}) async {
    try {
      final token =
          await ref.watch(secureStoargeProvider).readData('authToken');
      final response =
          await ApiMethod(url: "${ApiUrl.getOffers}/$id", token: token)
              .getDioRequest();
      return response;
    } catch (e) {
      log("Get Offer Error=> $e");
    }
  }

  Future getCategoriOffers({required String id}) async {
    log("id$id");
    try {
      final response = await ApiMethod(
        url: "${ApiUrl.getMansOffers}$id",
      ).getDioRequest();
      return response;
    } catch (e) {
      log("Get Offer Error=> $e");
    }
  }

  Future saveOffer(String id) async {
    try {
      final token =
          await ref.watch(secureStoargeProvider).readData('authToken');
      final response =
          await ApiMethod(url: "${ApiUrl.saveOffer}/$id/save", token: token)
              .putDioRequest();
      log("response$response");
      ShowSnackBarMsg(response['message'], color: Colors.green);
      return response;
    } catch (e) {
      log("Save offer error$e");
    }
  }

  Future removeOffer(String id) async {
    try {
      final token =
          await ref.watch(secureStoargeProvider).readData('authToken');
      final response =
          await ApiMethod(url: "${ApiUrl.removeOffer}/$id/unsave", token: token)
              .putDioRequest();
      ShowSnackBarMsg(response['message'], color: Colors.green);
      return response;
    } catch (e) {
      log("Save offer error$e");
    }
  }

  Future grabDeal(String id) async {
    try {
      final token =
          await ref.watch(secureStoargeProvider).readData('authToken');
      final response =
          await ApiMethod(url: "${ApiUrl.grabDeal}/$id/grab", token: token)
              .putDioRequest();
      ShowSnackBarMsg("${response["message"]}", color: Colors.green);
      return response;
    } on DioException catch (e) {
      if (Platform.isIOS && e.response!.data['error'] == "Unauthorized") {
        showAlertDialog("title", "message");
      }

      ShowSnackBarMsg("${e.response!.data['error']}", color: Colors.red);
    }
  }
}
