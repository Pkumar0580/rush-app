import 'package:flutter/material.dart';
import 'package:rush/features/auth/screens/age_selection.dart';
import '../../../utils/button.dart';
import '../../../utils/colors.dart';
import '../../../utils/message.dart';
import '../../../utils/navigation.dart';
import '../../../utils/sizes.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 20),
        child: Column(
          children: [
            const Text(
              "Select your Gender ",
              style: TextStyle(
                  fontSize: 40,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700),
            ),
            heightSizedBox(20.0),
            GenderSelectionDropdown(
              onGenderSelected: (gender) {
                setState(() {
                  selectedGender = gender;
                });
              },
            ),
            const Spacer(),
            Btn(
                text: "Continue",
                onPressed: () {
                  if (selectedGender == null) {
                    ShowSnackBarMsg("Plese select your gender?",
                        color: Colors.red);
                  } else {
                    navigationPush(
                        context,
                        AgeScreen(
                          gender: "$selectedGender",
                        ));
                  }
                })
          ],
        ),
      ),
    );
  }
}

List<String> genderItems = [
  "Male",
  "Female",
  "Other",
];

class GenderSelectionDropdown extends StatefulWidget {
  final void Function(String) onGenderSelected;

  const GenderSelectionDropdown({super.key, required this.onGenderSelected});

  @override
  _GenderSelectionDropdownState createState() =>
      _GenderSelectionDropdownState();
}

class _GenderSelectionDropdownState extends State<GenderSelectionDropdown> {
  String selectedGender = genderItems.first;

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
              selectedGender = value!;

              widget.onGenderSelected(selectedGender);
            });
          },
          items: genderItems
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
            hintText: 'Select Your Gender',
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
