import 'package:flutter/material.dart';

import '/models/place.dart';
import '/screens/place_details_screen.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) return Center(child: Text('No places added yet', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground)));

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(radius: 26, backgroundImage: FileImage(places[index].image)),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => PlaceDetailsScreen(place: places[index]))),
        title: Text(
          places[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        subtitle: Text(
          places[index].location.displayLocation,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      ),
    );
  }
}
