// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:rush/features/profile/repo/profile_repo.dart';

// final profileControllerProvider = Provider((ref) {
//   final repository = ref.watch(profileRepoProvider);
//   return ProfileController(resp: repository, ref: ref);
// });

// class ProfileController {
//   final ProfileRepo resp;
//   ProviderRef<Object?> ref;
//   // final AutoDisposeProviderRef<Object?> ref;

//   ProfileController({required this.resp, required this.ref});

//   Future getProfileController() async {

//     var response = await resp.getProfile();

//     if (response == 200) {
//       return response;
//     } else {

//     }
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/profile/repo/profile_repo.dart';
import 'package:rush/utils/message.dart';

final profileControllerProvider = Provider.autoDispose((ref) {
  final profileRepo = ref.watch(profileRepoProvider);
  return ProfileController(ref: ref, profileRepo: profileRepo);
});

class ProfileController {
  final AutoDisposeProviderRef<Object?> ref;
  final ProfileRepo profileRepo;

  ProfileController({required this.ref, required this.profileRepo});

  imageUpload({required File image}) async {
    log("imageUpload COnt=> $image");
    try {
      final res = profileRepo.imageUpload(image: image);

      ShowSnackBarMsg("Profile Picture Upload Successfully",
          color: Colors.green);

      log("Image Upload => $res");
    } catch (err) {
      log("Profile Controller Error=> $err");
    }
  }
}
