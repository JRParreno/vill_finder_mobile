import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/presentation/widgets/search_field.dart';
import 'package:vill_finder/features/map/domain/usecase/get_business_map_list.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = {};
  final searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vill Finder',
          style: TextStyle(
            color: ColorName.primary,
          ),
        ),
      ),
      body: BlocListener<MapBusinessBloc, MapBusinessState>(
        listener: (context, state) {
          if (state is MapBusinessSuccess) {
            _setMarker(state.data.results);
          }
        },
        child: Expanded(
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(14.5231427, 121.0164655),
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController controller) {
                  googleMapController.complete(controller);
                },
                onCameraIdle: () {
                  _fetchBusinesses();
                },
                markers: _markers,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SearchField(
                  onChanged: () {
                    setState(() {});
                  },
                  onClearText: () {
                    searchCtrl.clear();
                    setState(() {});
                    _fetchBusinesses();
                  },
                  controller: searchCtrl,
                  hintText: 'Search',
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: ColorName.darkerGreyFont,
                  ),
                  onSubmit: () {
                    _fetchBusinesses();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchBusinesses() async {
    final GoogleMapController mapController = await googleMapController.future;

    // Get the visible region (map bounds)
    LatLngBounds bounds = await mapController.getVisibleRegion();
    // Extract northeast and southwest bounds
    LatLng northeast = bounds.northeast;
    LatLng southwest = bounds.southwest;

    if (mounted) {
      context.read<MapBusinessBloc>().add(
            GetMapBusinessEvent(
              GetBusinessMapListParams(
                // businessName: searchCtrl.value.text,
                maxLatitude: northeast.latitude,
                maxLongitude: northeast.longitude,
                minLatitude: southwest.latitude,
                minLongitude: southwest.longitude,
              ),
            ),
          );
    }
  }

  void _setMarker(List<BusinessEntity> businesses) {
    List<Marker> tempMarkers = businesses
        .map(
          (e) => Marker(
            markerId: MarkerId(e.name),
            position: LatLng(e.latitude, e.longitude),
            infoWindow: InfoWindow(
              title: e.name,
              snippet: '${e.latitude}, ${e.longitude}',
            ),
          ),
        )
        .toList();

    setState(() {
      _markers.addAll(tempMarkers);
    });
  }
}
