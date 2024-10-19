// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/core/utils/utils_url_laucher.dart';

import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class PreviewLocation extends StatelessWidget {
  const PreviewLocation({
    super.key,
    required this.place,
  });

  final PlaceEntity place;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Create a marker for the given place
    final Marker placeMarker = Marker(
      markerId: MarkerId(
          place.createdAt.toString()), // Ensure a unique ID for the marker
      position: LatLng(place.latitude, place.longitude), // Marker position
      infoWindow: InfoWindow(title: place.name), // Optional info window
    );

    final Circle placeCircle = Circle(
      circleId:
          CircleId(place.createdAt.toString()), // Unique ID for the circle
      center: LatLng(place.latitude, place.longitude), // Center of the circle
      radius: 300, // Radius in meters (500m example)
      strokeColor: ColorName.primary, // Border color
      strokeWidth: 2, // Border width
      fillColor: ColorName.primary.withOpacity(0.3), // Fill color with opacity
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Location',
              style:
                  textTheme.headlineSmall?.copyWith(color: ColorName.blackFont),
            ),
            TextButton(
              onPressed: () {
                UtilsUrlLaucher.openGoogleMaps(
                    LatLng(place.latitude, place.longitude), place.name);
              },
              child: Text(
                'View in Map',
                style: textTheme.bodySmall?.copyWith(color: Colors.lightBlue),
              ),
            ),
          ],
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(color: ColorName.borderColor),
            borderRadius: BorderRadius.circular(15),
          ),
          height: MediaQuery.of(context).size.height * 0.35,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(place.latitude, place.longitude),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {},
            buildingsEnabled: true,
            markers: {placeMarker},
            circles: {placeCircle},
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
          ),
        ),
      ].withSpaceBetween(height: 10),
    );
  }
}
