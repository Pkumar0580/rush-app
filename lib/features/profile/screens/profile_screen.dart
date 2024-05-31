import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rush/features/profile/controller/profile_controller.dart';
import 'package:rush/features/profile/repo/profile_repo.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/colors.dart';
import '../../../utils/fields.dart';

final getProfileProvider = FutureProvider.autoDispose((ref) async {
  final getdata = await ref.watch(profileRepoProvider).getProfile();

  return getdata;
});

final pickedImageProvider = StateProvider<File?>((ref) => null);

class ProfileScreen extends ConsumerWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController location = TextEditingController();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getProfileData = ref.watch(getProfileProvider);
    final pickedImage = ref.watch(pickedImageProvider);

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
            log("Top offers=> $data");
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
                                child: pickedImage != null
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: FileImage(pickedImage),
                                      )
                                    : data['profile_pic'] != null
                                        ? CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Colors.grey,
                                            backgroundImage: NetworkImage(
                                                data['profile_pic']),
                                          )
                                        : const CircleAvatar(
                                            radius: 50,
                                            backgroundColor: Colors.grey,
                                            backgroundImage: AssetImage(
                                                "assets/images/avator.png"),
                                          ),
                              ),
                              // Container(
                              //   height: 130,
                              //   width: 140,
                              //   decoration: const BoxDecoration(
                              //     shape: BoxShape.circle,
                              //   ),
                              //   child: data['profile_pic'] != null
                              //       ? CircleAvatar(
                              //           radius: 50,
                              //           backgroundColor: Colors.grey,
                              //           backgroundImage:
                              //               NetworkImage(data['profile_pic']))
                              //       : pickedImage != null
                              //           ? CircleAvatar(
                              //               radius: 50,
                              //               backgroundColor: Colors.grey,
                              //               backgroundImage:
                              //                   FileImage(pickedImage))
                              //           : const CircleAvatar(
                              //               radius: 50,
                              //               backgroundColor: Colors.grey,
                              //               backgroundImage: AssetImage(
                              //                   "assets/images/avator.png"),
                              //             ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    File? image = await getImage(ref);
                                    if (image != null) {
                                      ref
                                          .read(profileControllerProvider)
                                          .imageUpload(image: image);
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
                        heightSizedBox(10.0),
                        Text(
                          data['name'] != null ? "${data['name']}" : "N/A",
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
                            initialValue: data['name'] != null
                                ? "${data['name']}"
                                : "N/A",
                            onTap: () {
                              name.text = "${data['name']}";
                            },
                            keyboardType: TextInputType.name,
                          ),
                          heightSizedBox(10.0),
                          CusTextField(
                            labelText: 'Phone no.',
                            initialValue: data['phone_no'] != null
                                ? "${data['phone_no']}"
                                : "N/A",
                            onTap: () {
                              log("Btn Pressed");
                            },
                            keyboardType: TextInputType.number,
                          ),
                          heightSizedBox(10.0),
                          CusTextField(
                            labelText: 'Email id',
                            initialValue: data['email'] != null
                                ? "${data['email']}"
                                : "N/A",
                            onTap: () {
                              log("Btn Pressed");
                            },
                            // controller: email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          heightSizedBox(10.0),
                          CusTextField(
                            labelText: 'Location',
                            initialValue: data['location'] ?? "N/A",
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
      enabled: true,
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

Future<File?> getImage(WidgetRef ref) async {
  try {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      ref.read(pickedImageProvider.notifier).state = imageFile;
      // File pickedImage = imageFile;

      // log("Picked Image=>>>$pickedImage");
      return imageFile;
    } else {
      log('User canceled or failed to pick an image');
      return null;
    }
  } catch (e) {
    log('Error picking image: $e');
    return null;
  }
}
