import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '/models/place.dart';
import '/screens/map_screen.dart';

class LocationInputWidget extends StatefulWidget {
  const LocationInputWidget({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation) onSelectLocation;

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  PlaceLocation? _pickedLocation;
  bool _isGettingLocation = false;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() => _isGettingLocation = true);
    locationData = await location.getLocation();

    if (locationData.latitude != null && locationData.longitude != null) {
      setState(() => _pickedLocation = PlaceLocation(
            latitude: locationData.latitude!,
            longitude: locationData.longitude!,
          ));
    }

    setState(() => _isGettingLocation = false);

    widget.onSelectLocation(_pickedLocation!);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_isGettingLocation) previewContent = const CircularProgressIndicator();

    if (_pickedLocation != null) {
      previewContent = Text(
        '${_pickedLocation!.latitude} ${_pickedLocation!.longitude}',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
      );
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(onPressed: _getCurrentLocation, icon: const Icon(Icons.location_on), label: const Text('Get current location')),
            TextButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen())), icon: const Icon(Icons.map), label: const Text('Select on map')),
          ],
        ),
      ],
    );
  }
}
