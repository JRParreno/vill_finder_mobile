import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilsUrlLaucher {
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<void> openGoogleMaps(LatLng latlng, String propertyName) async {
    final latitude = latlng.latitude;
    final longitude = latlng.longitude;
    final query = '$latitude,$longitude($propertyName)';
    final uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
