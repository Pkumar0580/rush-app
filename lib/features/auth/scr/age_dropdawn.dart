import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rush/features/auth/screens/gender_selection.dart';

class AgeSelectionDropdown extends StatefulWidget {
  const AgeSelectionDropdown({super.key});

  @override
  _AgeSelectionDropdownState createState() => _AgeSelectionDropdownState();
}

class _AgeSelectionDropdownState extends State<AgeSelectionDropdown> {
  String selectedAge = items.first;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButtonFormField<String>(
          // value: selectedAge,
          onChanged: (value) {
            setState(() {
              selectedAge = value!;
              log("Age=>$selectedAge");
            });
          },
          items: List.generate(100, (index) => index + 1).map((age) {
            return DropdownMenuItem<String>(
              value: age.toString(),
              child: Text(age.toString()),
            );
          }).toList(),
          decoration: const InputDecoration(
            hintText: 'Select Your Age', // Placeholder text
            border: InputBorder.none, // Remove internal border
          ),
        ),
      ),
    );
  }
}
