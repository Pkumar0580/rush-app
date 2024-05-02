import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/colors.dart';
import '../../../utils/fields.dart';

class ProfileScreen extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    statusBarColorChange(AppColor.statusBarColor);
    return SafeArea(
      child: Scaffold(
          // backgroundColor: AppColor.backgroundColor,
          appBar: AppBar(
            toolbarHeight: 50,
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xff204571),
            title: const Text("Profile"),
            automaticallyImplyLeading: true,
          ),
          body: Column(
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
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  AssetImage("assets/images/profileimage.png"),
                            ),
                           
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                /* ImagePicker imagePicker = ImagePicker();
                               XFile? xFile = await imagePicker.pickImage(
                                 source: ImageSource.gallery,
                               );
                               if (xFile != null) {
                                 path = xFile.path;
                                 saveImagePathToPrefs(path!);


                                 //setState(() {});
                               } */

                            
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
                    heightSizedBox(10.0),
                    const Text(
                      "NAME",
                      style: TextStyle(
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
                child: Column(
                  children: [
                    CusTextField(
                      labelText: 'Name',
                      onTap: () {
                        log("Btn Pressed");
                      },
                      controller: name,
                      keyboardType: TextInputType.name,
                    ),
                    heightSizedBox(10.0),
                    CusTextField(
                      labelText: 'Phone no.',
                      onTap: () {
                        log("Btn Pressed");
                      },
                      controller: phone,
                      keyboardType: TextInputType.number,
                    ),
                    heightSizedBox(10.0),
                    CusTextField(
                      labelText: 'Email id',
                      onTap: () {
                        log("Btn Pressed");
                      },
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    heightSizedBox(10.0),
                    CusTextField(
                      labelText: 'Location',
                      onTap: () {
                        log("Btn Pressed");
                      },
                      controller: location,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class CusTextField extends StatelessWidget {
  final String labelText;
  final Function() onTap;
  final TextEditingController? controller;

  final TextInputType? keyboardType;
  const CusTextField({
    super.key,
    required this.labelText,
    required this.onTap,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TxtField(
      fillColor: Colors.white,
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