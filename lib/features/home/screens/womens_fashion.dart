import 'package:flutter/material.dart';
import '../../../common/image_slider.dart';
import '../../../utils/colors.dart';

class WomensFashionScreen extends StatelessWidget {
  const WomensFashionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.appbarColor,
          foregroundColor: Colors.white,
          title: const Text("Ladies Fashion")),
      body: const Column(
        children: [ImageSlide()],
      ),
    );
  }
}
