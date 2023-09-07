import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;

  const PlaceLocation({required this.latitude, required this.longitude});

  String get displayLocation => 'Lat : $latitude, Long: $longitude';
}

class Place {
  final String title;
  final String id;
  final File image;
  final PlaceLocation location;

  Place({
    required this.title,
    required this.image,
    required this.location,
    id,
  }) : id = id ?? uuid.v4(); // overrides creation if one is received
}
