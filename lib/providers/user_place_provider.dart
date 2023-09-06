import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]);

  void addPlace(Place place) => state = [place, ...state];
}

final placeProvider = StateNotifierProvider<UserPlacesNotifier, List<Place>>((ref) => UserPlacesNotifier());
