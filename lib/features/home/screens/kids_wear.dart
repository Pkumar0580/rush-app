import 'package:flutter/material.dart';
import '../../../common/image_slider.dart';
import '../../../utils/colors.dart';

class KidsWear extends StatelessWidget {
  const KidsWear({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: AppColor.appbarColor,
          foregroundColor: Colors.white,
        title: const Text("Kids Wear")),
      body: const Column(
        children: [ImageSlide()],
      ),
    );
  }
}