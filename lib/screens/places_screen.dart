import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/user_place_provider.dart';
import '/screens/add_place_screen.dart';
import '/widgets/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<PlacesScreen> {
  void _addPlace() => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()));

  @override
  Widget build(BuildContext context) {
    final listOfPlaces = ref.watch(placeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Places'), actions: [IconButton(onPressed: _addPlace, icon: const Icon(Icons.add))]),
      body: Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: PlacesList(places: listOfPlaces)),
    );
  }
}
