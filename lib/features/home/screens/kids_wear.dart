import 'package:flutter/material.dart';

import '../../../common/image_slider.dart';

class KidsWear extends StatelessWidget {
  const KidsWear({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kids Wear")),
      body: const Column(
        children: [ImageSlide()],
      ),
    );
  }
}