import 'package:flutter/material.dart';

import '../../../common/image_slider.dart';

class WomensFashionScreen extends StatelessWidget {
  const WomensFashionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ladies Fashion")),
      body: const Column(
        children: [ImageSlide()],
      ),
    );
  }
}