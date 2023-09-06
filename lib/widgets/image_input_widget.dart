import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputWidget extends StatefulWidget {
  const ImageInputWidget({super.key, required this.onPicked});

  final void Function(File) onPicked;

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: Platform.isAndroid ? ImageSource.camera : ImageSource.gallery, maxWidth: 600);
    if (pickedImage == null) return;
    setState(() => _selectedImage = File(pickedImage.path));
    widget.onPicked(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera),
      label: const Text('Take picture'),
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(_selectedImage!, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
      );
    }

    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
      height: 250,
      width: double.infinity,
      child: content,
    );
  }
}
