import 'dart:developer';

import 'package:flutter/material.dart';

List<String> ageItems = [
  "Below 15",
  "15 to 20",
  "20 to 25",
  "25 to 30",
  "30 to 35",
  "35 to 50",
  "50 above",
];

class AgeSelectionDropdown extends StatefulWidget {
  final void Function(String) onAgeSelected;

  const AgeSelectionDropdown({super.key, required this.onAgeSelected});

  @override
  _AgeSelectionDropdownState createState() => _AgeSelectionDropdownState();
}

class _AgeSelectionDropdownState extends State<AgeSelectionDropdown> {
  String selectedAge = ageItems.first;

  _AgeSelectionDropdownState();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButtonFormField<String>(
          onChanged: (value) {
            setState(() {
              selectedAge = value!;

              widget.onAgeSelected(selectedAge);

              log("Age=>$selectedAge");
            });
          },
          items: ageItems
              .map(
                (item) => DropdownMenuItem(
                  alignment: AlignmentDirectional.centerStart,
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                ),
              )
              .toList(),
          decoration: const InputDecoration(
            hintText: 'Select Your Age',
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
