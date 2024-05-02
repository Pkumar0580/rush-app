import 'package:flutter/material.dart';

import '../../../utils/sizes.dart';

class SearchBarItem extends StatelessWidget {
  const SearchBarItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: width(context),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.search),
              widthSizedBox(5.0),
              const Text("Search for brands, deals or products")
            ],
          ),
        ),
      ),
    );
  }
}
