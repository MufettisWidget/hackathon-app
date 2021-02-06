import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  LatLng currentLocation;
  Location location = Location();

  StreamSubscription<LocationData> locationManager;

  stopLocationService() {
    if (locationManager != null) {
      locationManager.pause();
    }
  }

  resumeLocationService() {
    if (locationManager != null) {
      locationManager.resume();
    }
  }
}
