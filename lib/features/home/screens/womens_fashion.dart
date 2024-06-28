import 'package:flutter/material.dart';
import '../../../common/image_slider.dart';
import '../../../utils/colors.dart';
import 'mens_fashion.dart';

class WomensFashionScreen extends StatelessWidget {
  const WomensFashionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          foregroundColor: Colors.white,
          title: const Text("Ladies Fashion")),
      body: const SingleChildScrollView(
        child: Column(
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
