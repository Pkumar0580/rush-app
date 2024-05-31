import 'package:flutter/material.dart';

import '../../../common/image_slider.dart';

class AccessoriesScreen extends StatelessWidget {
  const AccessoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Accessories")),
      body: const Column(
        children: [ImageSlide()],
      ),
    );
  }
}
