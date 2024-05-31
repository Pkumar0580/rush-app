import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/fields.dart';
import '../screens/profile_screen.dart';

Future<dynamic> cusDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Input Required'),
          content: const TxtField(),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
}

final isEditingProvider = StateProvider.autoDispose<bool>((ref) => false);

class EditableTextField extends ConsumerWidget {
  final String? labelText, initialValue, hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function()? onTap;

  const EditableTextField(
      {super.key,
      this.labelText,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.initialValue,
      this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(isEditingProvider);
    return TxtField(
      fillColor: Colors.white,
      initialValue: initialValue,
      readOnly: !isEditing,
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      keyboardType: keyboardType,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(21),
        borderSide: const BorderSide(
          width: 0.2,
          color: Colors.black12,
        ),
      ),
      suffixIcon: Icon(isEditing ? Icons.done : Icons.edit),
      onTap: () {
        if (!isEditing) {
          ref.read(isEditingProvider.notifier).state = true;
        } else {
          ref.read(isEditingProvider.notifier).state = false;
        }
      },
    );
  }
}

Future<File?> getImage(WidgetRef ref) async {
  try {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      ref.read(pickedImageProvider.notifier).state = imageFile;
      return imageFile;
    }
  } catch (e) {
    log('Error picking image: $e');
    return null;
  }
  return null;
}
