import 'dart:io';

import '/widgets/image_input_widget.dart';
import '/widgets/location_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/place.dart';
import '/providers/user_place_provider.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _savePlace() {
    if (_titleController.text.trim().length > 2 || _selectedImage != null) {
      ref.read(placeProvider.notifier).addPlace(Place(_titleController.text, _selectedImage!));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new Place')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              ImageInputWidget(onPicked: (file) => _selectedImage = file),
              const SizedBox(height: 16),
              const LocationInputWidget(),
              const SizedBox(height: 16),
              ElevatedButton.icon(onPressed: _savePlace, icon: const Icon(Icons.add), label: const Text('Add Place'))
            ],
          ),
        ),
      ),
    );
  }
}
