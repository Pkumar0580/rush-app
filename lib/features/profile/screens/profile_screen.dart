import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rush/features/profile/repo/profile_repo.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/colors.dart';
import '../../../utils/fields.dart';



// final getProfileProvider = FutureProvider.family((ref, String id) async {
//   final getdata = await ref.watch(profileRepoProvider).getProfile(id);

//   return getdata;
// });


final getProfileProvider = FutureProvider((ref, ) async {
  final getdata = await ref.watch(profileRepoProvider).getProfile();

  return getdata;
});


class ProfileScreen extends ConsumerWidget {


  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();
  ProfileScreen(  {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    
    final getProfileData = ref.watch(getProfileProvider);

    // log("Profile Screen GetData=> $getProfileData");

    statusBarColorChange(AppColor.statusBarColor);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 50,
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff204571),
          title: const Text("Profile"),
          automaticallyImplyLeading: true,
        ),
        body: getProfileData.when(
          data: (data) {
            log("Data==========>$data");
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: null,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xff204571),
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                height: 130,
                                width: 140,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.grey,
                                  backgroundImage:
                                      NetworkImage(data[0]['profile_pic']),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    final imagePicker = ImagePicker();

                                    Future<void> pickImageFromGallery() async {
                                      final pickedFile =
                                          await imagePicker.pickImage(
                                              source: ImageSource.gallery);

                                      if (pickedFile != null) {
                                      } else {
                                        print(
                                            'User canceled or failed to pick an image');
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff1F0A68),
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          data[0]['name'],
                          // data['name'].toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        heightSizedBox(10.0),
                      ],
                    ),
                  ),
                  heightSizedBox(10.0),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CusTextField(
                            labelText: "Name",
                            initialValue: data[0]['name'],
                            onTap: () {},
                            keyboardType: TextInputType.name,
                          ),
                          heightSizedBox(10.0),
                          CusTextField(
                            labelText: 'Phone no.',
                            initialValue: data[0]['phone_no'],
                            onTap: () {
                              log("Btn Pressed");
                            },
                            keyboardType: TextInputType.number,
                          ),
                          heightSizedBox(10.0),
                          CusTextField(
                            labelText: 'Email id',
                            initialValue: data[0]['email'],
                            onTap: () {
                              log("Btn Pressed");
                            },
                            // controller: email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          heightSizedBox(10.0),
                          CusTextField(
                            labelText: 'Location',
                            onTap: () {
                              log("Btn Pressed");
                            },
                            // controller: location,
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          error: (error, stackTrace) =>
              const Center(child: Text("Something Went Wrong")),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class CusTextField extends StatelessWidget {
  final String? labelText, initialValue;
  final Function() onTap;
  final TextEditingController? controller;

  final TextInputType? keyboardType;
  const CusTextField(
      {super.key,
      this.labelText,
      required this.onTap,
      this.controller,
      this.keyboardType,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TxtField(
      fillColor: Colors.white,
      initialValue: initialValue,
      enabled: false,
      controller: controller,
      labelText: labelText,
      keyboardType: keyboardType,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(21),
          borderSide: const BorderSide(
            width: 0.2,
            color: Colors.black12,
          )),
      suffixIcon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: onTap,
              child: const Text(
                "Edit",
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Color(0xff413DF8)),
              )),
          Container(
            height: 1.5,
            width: 23,
            color: const Color(0xff413DF8),
          )
        ],
      ),
    );
  }
}






// class ProfileUploadScr extends ConsumerWidget {
//   const ProfileUploadScr({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final picBuild = ref.watch(profilePicProvider);

//     return InkWell(
//       splashColor: Colors.white,
//       onTap: () async {
//         Uint8List? imageData = await pickImageFromGallery();

//         ref.read(profilePicProvider.notifier).state = imageData;

//         snackBarMsg(imageData != null ? picUplodMsg : picNotUploadMsg,
//             color: imageData != null ? Colors.green : Colors.red);
//       },
//       child: Center(
//           child: picBuild != null
//               ? CircleProfilePage(bytes: picBuild, radius1: 50, radius2: 49)
//               : CircleProfilePage(radius1: 50, radius2: 49)),
//     );
//   }
// }