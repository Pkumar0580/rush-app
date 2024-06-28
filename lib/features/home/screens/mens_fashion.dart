import 'package:flutter/material.dart';
import 'package:rush/common/image_slider.dart';
import 'package:rush/features/offer/components/offer_screen_comp.dart';
import 'package:rush/utils/sizes.dart';
import '../../../utils/colors.dart';
import '../../../utils/navigation.dart';
import '../../offer/screens/offers_screen.dart';

class MensFashionScreen extends StatelessWidget {
  const MensFashionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          foregroundColor: Colors.white,
          title: const Text("Mens Fashion")),
      body: const SingleChildScrollView(
        child:  Column(
          children: [
            ImageSlide(),
            SubCategoryCard(title: "Formals"),
            SubCategoryCard(title: "Ethnic"),
            SubCategoryCard(title: "Sports"),
          ],
        ),
      ),
    );
  }
}

class SubCategoryCard extends StatelessWidget {
  final String? title;
  const SubCategoryCard({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  navigationPush(context, const OffersScreen());
                },
                child: const Row(
                  children: [
                    Text(
                      "VIEW ALL",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Color(0xff0D2949),
                    ),
                  ],
                ),
              )
            ],
          ),
          heightSizedBox(10.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int a = 0; a < 5; a++) const OffersCardBrandScr(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
