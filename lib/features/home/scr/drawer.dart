import 'package:flutter/material.dart';

import '../../../utils/sizes.dart';

class CusDrawer extends StatelessWidget {
  const CusDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: width(context),
          color: const Color(0xff133964),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage("assets/images/profileimage.png"),
              ),
              heightSizedBox(15.0),
              const Text(
                "NAME",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        heightSizedBox(15.0),
        ListTile(
          leading: const Icon(Icons.settings, color: Color(0xff000000)),
          title: const Text("Profile Settings",
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.local_offer, color: Color(0xff000000)),
          title: const Text("My Offers",
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {
            // navigationPush(context, BrandsDetails());
          },
        ),
        ListTile(
          leading:
              const Icon(Icons.branding_watermark, color: Color(0xff000000)),
          title: const Text("My Brands",
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.call, color: Color(0xff000000)),
          title: const Text("Call Us",
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {},
        ),
        const Spacer(),
        ListTile(
          leading: const Icon(Icons.star, color: Color(0xff000000)),
          title: const Text("Rate Us",
              style: TextStyle(fontWeight: FontWeight.w500)),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text("Logout",
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.red)),
          onTap: () {},
        ),
      ],
    );
  }
}
