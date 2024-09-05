import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/auth/screens/login_image.dart';
import 'package:rush/features/home/scr/rating_page.dart';
import 'package:rush/features/offer/screens/myoffer_screen.dart';
import 'package:rush/utils/bottom_bar.dart';
import 'package:rush/utils/navigation.dart';
import 'package:rush/utils/secure_storage%20copy.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/sizes.dart';
import '../../profile/repo/profile_repo.dart';

final getProfileProvider = FutureProvider.autoDispose((ref) async {
  final getdata = await ref.watch(profileRepoProvider).getProfile();

  return getdata;
});

class CusDrawer extends ConsumerWidget {
  const CusDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getProfile = ref.watch(getProfileProvider);
    return Column(
      children: [
        Container(
            height: 200,
            width: width(context),
            color: const Color(0xff133964),
            child: getProfile.when(
              data: (data) {
                if (Platform.isIOS && data == null) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: ClipOval(
                          child: data['profile_pic'] != null &&
                                  data['profile_pic'].isNotEmpty
                              ? FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/avator.png',
                                  image: data['profile_pic'],
                                  fit: BoxFit.cover,
                                  width: 100.0,
                                  height: 100.0,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/avator.png',
                                      fit: BoxFit.cover,
                                      width: 100.0,
                                      height: 100.0,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/avator.png',
                                  fit: BoxFit.cover,
                                  width: 100.0,
                                  height: 100.0,
                                ),
                        ),
                      ),
                    ],
                  );
                }
                if (data == null) {
                  return const Center(
                    child: Text(
                      "Something went wrong",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: ClipOval(
                        child: data['profile_pic'] != null &&
                                data['profile_pic'].isNotEmpty
                            ? FadeInImage.assetNetwork(
                                placeholder: 'assets/images/avator.png',
                                image: data['profile_pic'],
                                fit: BoxFit.cover,
                                width: 100.0,
                                height: 100.0,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/avator.png',
                                    fit: BoxFit.cover,
                                    width: 100.0,
                                    height: 100.0,
                                  );
                                },
                              )
                            : Image.asset(
                                'assets/images/avator.png',
                                fit: BoxFit.cover,
                                width: 100.0,
                                height: 100.0,
                              ),
                      ),
                    ),
                    heightSizedBox(15.0),
                    Text(
                      data['name'] ?? "N/A",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                );
              },
              error: (error, stackTrace) => const Text("Something went wrong"),
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              },
            )),
        heightSizedBox(15.0),
        ListTile(
          leading: const Icon(Icons.home, color: Color(0xff000000)),
          title:
              const Text("Home", style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            navigatePushReplacement(const BottomBar());
          },
        ),
        ListTile(
          leading: const Icon(Icons.local_offer, color: Color(0xff000000)),
          title: const Text("My Offers",
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            navigationPush(context, const MyOffers());
          },
        ),
        // ListTile(
        //   leading:
        //       const Icon(Icons.branding_watermark, color: Color(0xff000000)),
        //   title: const Text("My Brands",
        //       style: TextStyle(fontWeight: FontWeight.w500)),
        //   onTap: () {},
        // ),
        ListTile(
          leading: const Icon(Icons.call, color: Color(0xff000000)),
          title: const Text("Call Us",
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            openPhoneDialer("9928396528");
          },
        ),
        const Spacer(),
        ListTile(
          leading: const Icon(Icons.star, color: Color(0xff000000)),
          title: const Text("Rate Us",
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            navigationPush(context, RatingPage());
          },
        ),
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.red)),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            ref
                                .read(secureStoargeProvider)
                                .deleteData("authToken");
                            navigateTo(const LoginImage());
                          },
                        ),
                      ],
                    );
                  },
                );
              });
        })
      ],
    );
  }
}

void openPhoneDialer(String phoneNumber) async {
  final Uri phoneDialerUri = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunchUrl(phoneDialerUri)) {
    await launchUrl(phoneDialerUri);
  } else {
    throw 'Could not launch $phoneDialerUri';
  }
}
