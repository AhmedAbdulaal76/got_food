import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();

  File? get image => _ImagePickerWidgetState()._image;
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: _image != null
          ? CircleAvatar(
              radius: 90,
              backgroundImage: FileImage(_image!),
            )
          : CircleAvatar(
              radius: 50,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
              child: const Icon(Icons.camera_alt, size: 30),
            ),
    );
  }
}
