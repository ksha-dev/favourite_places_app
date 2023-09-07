import 'dart:io';

import '/providers/user_place_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '/widgets/location_input_widget.dart';
import '/widgets/image_input_widget.dart';
import '/models/place.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _savePlace() {
    if (_titleController.text.trim().length > 2 || _selectedImage != null || _selectedLocation != null) {
      ref.read(placeProvider.notifier).addPlace(Place(
            title: _titleController.text,
            image: _selectedImage!,
            location: _selectedLocation!,
          ));
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
              LocationInputWidget(onSelectLocation: (location) => _selectedLocation = location),
              const SizedBox(height: 16),
              ElevatedButton.icon(onPressed: _savePlace, icon: const Icon(Icons.add), label: const Text('Add Place'))
            ],
          ),
        ),
      ),
    );
  }
}
