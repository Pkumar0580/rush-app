

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
