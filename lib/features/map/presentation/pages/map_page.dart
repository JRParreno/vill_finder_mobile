import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/features/food/presentation/blocs/food/food_bloc.dart';
import 'package:vill_finder/features/food/presentation/pages/body/food_body.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/presentation/widgets/search_field.dart';
import 'package:vill_finder/features/map/domain/entities/search_map_response_entity.dart';
import 'package:vill_finder/features/map/domain/usecase/get_business_map_list.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental/rental_bloc.dart';
import 'package:vill_finder/features/rental/presentation/pages/body/rental_body.dart';
import 'package:vill_finder/features/review/presentation/bloc/review_list_bloc.dart';
import 'package:vill_finder/gen/assets.gen.dart';
import 'package:vill_finder/gen/colors.gen.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

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
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: BlocListener<MapBusinessBloc, MapBusinessState>(
          listener: (context, state) {
            if (state is MapBusinessSuccess) {
              _setMarker(state.data.results);
            }
          },
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: GoogleMap(
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

  void _setMarker(SearchMapResultsEntity mapResults) async {
    final foodDefaultIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(30, 30)), // Adjust size as needed
      Assets.images.bitmap.food.keyName,
    );

    final rentalDefaultIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(30, 30)), // Adjust size as needed
      Assets.images.bitmap.rental.keyName,
    );

    List<Marker> tempFoodMarkers = mapResults.foods
        .map(
          (e) => Marker(
            icon: e.place.bitMapIcon != null
                ? BitmapDescriptor.bytes(e.place.bitMapIcon!,
                    height: 30, width: 30)
                : foodDefaultIcon,
            markerId: MarkerId(e.place.name),
            position: LatLng(e.place.latitude, e.place.longitude),
            infoWindow: InfoWindow.noText,
            onTap: () => handleOnTapFood(e),
          ),
        )
        .toList();

    List<Marker> tempRentalMarkers = mapResults.rentals
        .map(
          (e) => Marker(
            onTap: () => handleOnTapRental(e),
            icon: e.place.bitMapIcon != null
                ? BitmapDescriptor.bytes(e.place.bitMapIcon!,
                    height: 30, width: 30)
                : rentalDefaultIcon,
            markerId: MarkerId(e.place.name),
            position: LatLng(e.place.latitude, e.place.longitude),
            infoWindow: InfoWindow.noText,
          ),
        )
        .toList();

    setState(() {
      _markers.addAll(tempFoodMarkers);
      _markers.addAll(tempRentalMarkers);
    });
  }

  void handleOnTapRental(RentalEntity value) {
    context.read<RentalBloc>().add(
          GetRentalEvent(value.id),
        );
    context.read<ReviewListBloc>().add(
          GetReviewsEvent(placeId: value.id, reviewType: ReviewType.rental),
        );

    WoltModalSheet.show(
      context: context,
      pageListBuilder: (bottomSheetContext) => [
        SliverWoltModalSheetPage(
          useSafeArea: true,
          hasTopBarLayer: true,
          mainContentSliversBuilder: (context) => [
            SliverToBoxAdapter(
              child: RentalBody(rental: value),
            )
          ],
        )
      ],
    );
  }

  void handleOnTapFood(FoodEstablishmentEntity value) {
    context.read<FoodBloc>().add(
          GetFoodEvent(value.id),
        );
    context.read<ReviewListBloc>().add(
          GetReviewsEvent(
              placeId: value.id, reviewType: ReviewType.foodestablishment),
        );
    WoltModalSheet.show(
      context: context,
      pageListBuilder: (bottomSheetContext) => [
        SliverWoltModalSheetPage(
          useSafeArea: true,
          hasTopBarLayer: true,
          mainContentSliversBuilder: (context) => [
            SliverToBoxAdapter(
              child: FoodBody(food: value),
            )
          ],
        )
      ],
    );
  }
}
