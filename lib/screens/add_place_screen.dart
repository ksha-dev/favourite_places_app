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

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_titleController.text.trim().length > 2) {
      ref.read(placeProvider.notifier).addPlace(Place(_titleController.text));
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
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _onSave,
                icon: const Icon(Icons.add),
                label: const Text('Add Place'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
