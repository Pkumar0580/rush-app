import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rush/features/profile/controller/profile_controller.dart';
import 'package:rush/features/profile/repo/profile_repo.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/bottom_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/fields.dart';
import '../../../utils/navigation.dart';

// Providers for managing state
final getProfileProvider = FutureProvider.autoDispose((ref) async {
  final getdata = await ref.watch(profileRepoProvider).getProfile();
  return getdata;
});

final pickedImageProvider = StateProvider<File?>((ref) => null);
final isLoadingProvider = StateProvider<bool>((ref) => false);

// Providers for managing editable state of each text field
final isNameEditableProvider = StateProvider<bool>((ref) => false);
final isPhoneEditableProvider = StateProvider<bool>((ref) => false);
final isEmailEditableProvider = StateProvider<bool>((ref) => false);
final isLocationEditableProvider = StateProvider<bool>((ref) => false);

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
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 50,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff204571),
        title: const Text("Profile"),
        leading: IconButton(
          onPressed: () {
            navigateTo(const BottomBar());
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        children: [
          // Main content
          getProfileData.when(
            data: (data) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
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
                                          backgroundImage:
                                              FileImage(pickedImage),
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      File? image = await getImage(ref);
                                      if (image != null) {
                                        ref
                                            .read(isLoadingProvider.notifier)
                                            .state = true;
                                        await ref
                                            .read(profileControllerProvider)
                                            .imageUpload(image: image);
                                        ref
                                            .read(isLoadingProvider.notifier)
                                            .state = false;
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
                      child: Column(
                        children: [
                          CusTextField(
                            labelText: "Name",
                            initialValue: data['name'] != null
                                ? "${data['name']}"
                                : "N/A",
                            isEditableProvider: isNameEditableProvider,
                          ),
                          heightSizedBox(10.0),
                          CusTextField(
                            labelText: 'Phone no.',
                            initialValue: data['phone_no'] != null
                                ? "${data['phone_no']}"
                                : "N/A",
                            isEditableProvider: isPhoneEditableProvider,
                          ),
                          heightSizedBox(10.0),
                          CusTextField(
                            labelText: 'Email id',
                            initialValue: data['email'] != null
                                ? "${data['email']}"
                                : "N/A",
                            isEditableProvider: isEmailEditableProvider,
                          ),
                          heightSizedBox(10.0),
                          CusTextField(
                            labelText: 'Location',
                            initialValue: data['location'] ?? "N/A",
                            isEditableProvider: isLocationEditableProvider,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) =>
                const Center(child: Text("Something Went Wrong")),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          // Loading indicator
          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class CusTextField extends ConsumerWidget {
  final String? labelText, initialValue;
  final TextEditingController? controller;
  final StateProvider<bool> isEditableProvider;
  final TextInputType? keyboardType;

  CusTextField(
      {super.key,
      this.labelText,
      this.controller,
      this.keyboardType,
      this.initialValue,
      required this.isEditableProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditable = ref.watch(isEditableProvider);

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TxtField(
          fillColor: Colors.white,
          initialValue: initialValue,
          enabled: isEditable,
          controller: controller,
          labelText: labelText,
          keyboardType: keyboardType,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: const BorderSide(
                width: 0.2,
                color: Colors.black12,
              )),
        ),
        Positioned(
          right: 10,
          child: InkWell(
            onTap: () {
              ref.read(isEditableProvider.notifier).state = !isEditable;
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                isEditable ? "Done" : "Edit",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff413DF8),
                ),
              ),
            ),
          ),
        ),
      ],
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
