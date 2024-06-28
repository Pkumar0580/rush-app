import 'package:flutter/material.dart';
import '../../../common/image_slider.dart';
import '../../../utils/colors.dart';
import 'mens_fashion.dart';

class KidsWear extends StatelessWidget {
  const KidsWear({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          foregroundColor: Colors.white,
          title: const Text("Kids Wear")),
      // ignore: prefer_const_constructors
      body: SingleChildScrollView(
        child: const Column(
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
