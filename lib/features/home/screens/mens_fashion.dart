import 'package:flutter/material.dart';
import 'package:rush/common/image_slider.dart';
import '../../../utils/colors.dart';

class MensFashionScreen extends StatelessWidget {
  const MensFashionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          foregroundColor: Colors.white,
          title: const Text("Mens Fashion")),
      body: const Column(
        children: [ImageSlide()],
      ),
    );
  }
}
