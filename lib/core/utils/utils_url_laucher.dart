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

  static Future<void> openGoogleMaps(LatLng latlng) async {
    final String googleMapslocationUrl =
        "https://www.google.com/maps/search/?api=1&query=${latlng.latitude},${latlng.longitude}";

    final Uri launchUri = Uri(
      scheme: 'geo',
      path: googleMapslocationUrl,
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }
}
