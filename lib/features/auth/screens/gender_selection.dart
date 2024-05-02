import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/auth/screens/age_selection.dart';

import '../../../utils/button.dart';
import '../../../utils/colors.dart';
import '../../../utils/navigation.dart';
import '../../../utils/sizes.dart';

final selectedGenderProvider = StateProvider<String>((ref) => '');

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
            GenderDropDawn(
              onChanged: (value) {
                selectedGender = value;
              },
            ),
            const Spacer(),
            Btn(
                text: "Continue",
                onPressed: () {
                  if (selectedGender == null) {
                    snackBarMsg("plese select vlaue");
                  }
                  navigationPush(
                      context,
                      AgeScreen(
                        gender: "$selectedGender",
                      ));
                })
          ],
        ),
      ),
    );
  }
}

List<String> items = [
  "Select Here",
  "Male",
  "Female",
  "Other",
];

class GenderDropDawn extends StatefulWidget {
  final ValueChanged<String?> onChanged;
  const GenderDropDawn({super.key, required this.onChanged});

  @override
  State<GenderDropDawn> createState() => _GenderDropDawnState();
}

class _GenderDropDawnState extends State<GenderDropDawn> {
  String? selectedItem = items.first;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: width(context),
      child: Card(
        color: Colors.white,
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<String>(
              icon: const Icon(Icons.arrow_drop_down),
              dropdownColor: Colors.white,
              iconSize: 36,
              isExpanded: true,
              elevation: 1,
              value: selectedItem,
              style: const TextStyle(color: Colors.black, fontSize: 22),
              items: items
                  .map((item) => DropdownMenuItem(
                        alignment: AlignmentDirectional.centerStart,
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                      ))
                  .toList(),
              onChanged: (item) {
                setState(
                  () {
                    selectedItem = item;
                    log("Selected Item=> ${selectedItem.runtimeType}");

                    widget.onChanged(item);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// class GenderDropdown extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedGender = ref.watch(selectedGenderProvider);
//     final List<String> genderValue = ['Male', 'Female', 'Other'];

//     return DropdownButton<String>(
//       value: selectedGender,
//       items: genderValue
//           .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//           .toList(),
//       onChanged: (value) =>
//           ref.read(selectedGenderProvider.notifier).state = value!,
//     );
//   }
// }

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void snackBarMsg(String message, {Color? color}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
    backgroundColor: color,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}
