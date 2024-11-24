import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Default position to return when permissions or services are unavailable.
  final Position defaultPosition = Position(
    latitude: 0.0,
    longitude: 0.0,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    altitudeAccuracy: 0.0,
    headingAccuracy: 0.0,
  );

  /// Gets the current location or returns a default position.
  Future<Position> getCurrentLocationOrDefault() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return defaultPosition; // Return default position if services are disabled
      }

      // Check and request permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return defaultPosition; // Return default position if permissions are denied
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return defaultPosition; // Return default position if permissions are permanently denied
      }

      // Get the current position
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      // If any error occurs, return the default position
      return defaultPosition;
    }
  }
}
