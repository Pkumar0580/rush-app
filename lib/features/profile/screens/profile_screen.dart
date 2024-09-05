import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rush/features/auth/repo/auth_repo.dart';
import 'package:rush/features/profile/controller/profile_controller.dart';
import 'package:rush/features/profile/repo/profile_repo.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/bottom_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/fields.dart';
import '../../../utils/navigation.dart';
import '../../auth/screens/login_image.dart';

// Providers for managing state
final getProfileProvider = FutureProvider.autoDispose((ref) async {
  final getdata = await ref.watch(profileRepoProvider).getProfile();
  ref.keepAlive();
  return getdata;
});

final pickedImageProvider = StateProvider<File?>((ref) => null);
final isLoadingProvider = StateProvider<bool>((ref) => false);

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
              log("dataeaprofile=>>>$data");
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
                          TxtField(
                            labelText: "Name",
                            enabled: false,
                            controller: TextEditingController(
                                text: data['name'] != null
                                    ? "${data['name']}"
                                    : "N/A"),
                          ),
                          heightSizedBox(10.0),
                          TxtField(
                            labelText: 'Phone no.',
                            enabled: false,
                            controller: TextEditingController(
                                text: data['phone_no'] != null
                                    ? "${data['phone_no']}"
                                    : "N/A"),
                          ),
                          heightSizedBox(10.0),
                          TxtField(
                            labelText: 'Email id',
                            enabled: false,
                            controller: TextEditingController(
                                text: data['email'] != null
                                    ? "${data['email']}"
                                    : "N/A"),
                          ),
                          heightSizedBox(10.0),
                          TxtField(
                            labelText: 'Location',
                            enabled: false,
                            controller: TextEditingController(
                                text: data['location'] != null
                                    ? "${data['location']}"
                                    : "N/A"),
                          ),
                          heightSizedBox(10.0),
                          SizedBox(
                              width: width(context),
                              child: ElevatedButton(
                                  onPressed: () {
                                    _showEditDialog(context, ref);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.appbarColor,
                                      foregroundColor: Colors.white),
                                  child: const Text(
                                    "Edit",
                                  ))),
                          heightSizedBox(10.0),
                          SizedBox(
                              width: width(context),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Logout'),
                                          content: const Text(
                                              'Are you sure you want to Delete your Account?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('No'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Yes'),
                                              onPressed: () async {
                                                await ref
                                                    .read(authRepoProvider)
                                                    .deleteAccount();
                                                navigateTo(const LoginImage());
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.appbarColor,
                                      foregroundColor: Colors.white),
                                  child: const Text(
                                    "Delete Account",
                                  )))
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

void _showEditDialog(BuildContext context, WidgetRef ref) {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.backgroundColor,
        title: const Text('Edit Details'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TxtField(
                labelText: "Name",
                controller: nameController,
              ),
              heightSizedBox(5.0),
              TxtField(
                labelText: "Email",
                controller: emailController,
              ),
              heightSizedBox(5.0),
              TxtField(
                labelText: "Location",
                controller: locationController,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return ElevatedButton(
                child: const Text('Done'),
                onPressed: () async {
                  await ref.read(authRepoProvider).editProfile(
                      name: nameController.text,
                      email: emailController.text,
                      location: locationController.text);
                  // Refresh the profile data provider
                  ref.refresh(getProfileProvider);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ],
      );
    },
  );
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
