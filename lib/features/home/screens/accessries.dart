import 'package:flutter/material.dart';
import '../../../common/image_slider.dart';
import '../../../utils/colors.dart';
import 'mens_fashion.dart';

class AccessoriesScreen extends StatelessWidget {
  const AccessoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          foregroundColor: Colors.white,
          title: const Text("Accessories")),
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
