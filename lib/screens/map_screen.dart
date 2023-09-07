import '/models/place.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(latitude: 37.42, longitude: -122.084),
    this.isSelecting = true,
  });
  // setting a default location if one is not needed mandatorily

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Pick your location' : 'Your Location'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
      ),
    );
  }
}
