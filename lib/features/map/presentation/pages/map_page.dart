import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:vill_finder/core/common/widgets/loader.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/enum/view_status.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/core/router/app_routes.dart';
import 'package:vill_finder/features/food/presentation/blocs/food/food_bloc.dart';
import 'package:vill_finder/features/food/presentation/pages/body/food_body.dart';
import 'package:vill_finder/features/food/presentation/pages/body/food_loading.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/presentation/blocs/cubit/cubit/category_cubit.dart';
import 'package:vill_finder/features/home/presentation/widgets/search_field.dart';
import 'package:vill_finder/features/map/domain/entities/search_map_response_entity.dart';
import 'package:vill_finder/features/map/domain/usecase/get_business_map_list.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';
import 'package:vill_finder/features/map/presentation/body/filter_overlay_body.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental/rental_bloc.dart';
import 'package:vill_finder/features/rental/presentation/pages/body/rental_body.dart';
import 'package:vill_finder/features/rental/presentation/pages/body/rental_loading.dart';
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
  final reviewCtrl = TextEditingController();

  @override
  void initState() {
    context.read<CategoryCubit>().getCategoryList();
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
              handleOverrideResult(state);

              if (state.viewStatus == ViewStatus.loading) {
                LoadingScreen.instance().show(context: context);
              }

              if (state.viewStatus == ViewStatus.successful ||
                  state.viewStatus == ViewStatus.failed) {
                LoadingScreen.instance().hide();
              }
            }
          },
          child: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: GoogleMap(
                  zoomGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  mapType: MapType.terrain,
                  buildingsEnabled: false,
                  indoorViewEnabled: false,
                  trafficEnabled: false,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SearchField(
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
                      onTap: () {
                        context.pushNamed(AppRoutes.homeSearch.name);
                      },
                      readOnly: true,
                    ),
                    FilterOverlayBody(
                      text: searchCtrl.value.text,
                    ),
                  ].withSpaceBetween(height: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchBusinesses() async {
    final currentState = context.read<MapBusinessBloc>().state;
    bool isOverride =
        currentState is MapBusinessSuccess ? currentState.isOverrideMap : false;
    if (!isOverride) {
      final GoogleMapController mapController =
          await googleMapController.future;

      // Get the visible region (map bounds)
      LatLngBounds bounds = await mapController.getVisibleRegion();
      // Extract northeast and southwest bounds

      LatLng northeast = bounds.northeast;
      LatLng southwest = bounds.southwest;
      double centerLat = (northeast.latitude + southwest.latitude) / 2;
      double centerLng = (northeast.longitude + southwest.longitude) / 2;

      LatLng center = LatLng(centerLat, centerLng);

      if (mounted) {
        context.read<MapBusinessBloc>().add(
              GetMapBusinessEvent(
                GetBusinessMapListParams(
                  latitude: center.latitude,
                  longitude: center.longitude,
                ),
              ),
            );
      }
    }
  }

  void _setMarker(SearchMapResultsEntity mapResults) async {
    setState(() {
      _markers.clear();
    });

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
          trailingNavBarWidget: GestureDetector(
            onTap: () {
              context.pop();

              Future.delayed(const Duration(milliseconds: 450), () {
                context.pushNamed(
                  AppRoutes.rental.name,
                  pathParameters: {"id": value.id.toString()},
                );
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'View',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                  const Icon(
                    Icons.open_in_new,
                    color: Colors.blue,
                    size: 15,
                  ),
                ].withSpaceBetween(width: 5),
              ),
            ),
          ),
          mainContentSliversBuilder: (context) => [
            SliverToBoxAdapter(
              child: BlocBuilder<RentalBloc, RentalState>(
                builder: (context, state) {
                  if (state is RentalLoading) {
                    return const RentalLoadingWidget();
                  }

                  if (state is RentalFailure) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'Something went wrong in our server, please try again later.',
                        ),
                      ),
                    );
                  }

                  if (state is RentalSuccess) {
                    return RentalBody(
                      isModalView: true,
                      rental: state.rental,
                      controller: reviewCtrl,
                      onChangeTapGallery: (index) {
                        handleOpenGallery(remoteImages: [
                          ...value.place.photos.map(
                            (e) => CachedNetworkImage(
                              width: double.infinity,
                              fit: BoxFit.cover,
                              imageUrl: e.image,
                              placeholder: (context, url) => const Center(
                                  child:
                                      CircularProgressIndicator()), // Optional placeholder
                              errorWidget: (context, url, error) => Assets
                                  .images.placeholder.imagePlaceholder
                                  .image(
                                      fit: BoxFit.cover,
                                      width: double.infinity),
                            ),
                          )
                        ], index: index);
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
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
          trailingNavBarWidget: GestureDetector(
            onTap: () {
              context.pop();

              Future.delayed(const Duration(milliseconds: 450), () {
                context.pushNamed(AppRoutes.food.name,
                    pathParameters: {"id": value.id.toString()});
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'View',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                  const Icon(
                    Icons.open_in_new,
                    color: Colors.blue,
                    size: 15,
                  ),
                ].withSpaceBetween(width: 5),
              ),
            ),
          ),
          mainContentSliversBuilder: (context) => [
            SliverToBoxAdapter(
              child: BlocBuilder<FoodBloc, FoodState>(
                builder: (context, state) {
                  if (state is FoodLoading) {
                    return const FoodLoadingWidget();
                  }

                  if (state is FoodFailure) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'Something went wrong in our server, please try again later.',
                        ),
                      ),
                    );
                  }
                  if (state is FoodSuccess) {
                    return FoodBody(
                      isModalView: true,
                      food: state.food,
                      controller: reviewCtrl,
                      onChangeTapGallery: (index) {
                        handleOpenGallery(remoteImages: [
                          ...value.place.photos.map(
                            (e) => CachedNetworkImage(
                              width: double.infinity,

                              fit: BoxFit.cover,
                              imageUrl: e.image,
                              placeholder: (context, url) => const Center(
                                  child:
                                      CircularProgressIndicator()), // Optional placeholder
                              errorWidget: (context, url, error) => Assets
                                  .images.placeholder.imagePlaceholder
                                  .image(
                                      fit: BoxFit.cover,
                                      width: double.infinity),
                            ),
                          )
                        ], index: index);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        )
      ],
    );
  }

  void handleOverrideResult(MapBusinessSuccess value) async {
    if (value.isOverrideMap) {
      final food = value.food;
      final rental = value.rental;
      searchCtrl.text = value.params.name ?? '';

      if (food != null && rental != null) return;
      final GoogleMapController controller = await googleMapController.future;
      LatLng latLng = const LatLng(14.5231427, 121.0164655);

      if (food != null) {
        latLng = LatLng(food.place.latitude, food.place.longitude);
      }

      if (rental != null) {
        latLng = LatLng(rental.place.latitude, rental.place.longitude);
      }

      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 14.4746,
          ),
        ),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        if (food != null) {
          handleOnTapFood(food);
        }

        if (rental != null) {
          handleOnTapRental(rental);
        }

        if (mounted) {
          context.read<MapBusinessBloc>().add(ResetMapOverrideStatus());
        }
      });
    }
  }

  void handleOpenGallery({
    required List<Widget> remoteImages,
    required int index,
  }) {
    SwipeImageGallery(
      context: context,
      children: remoteImages,
      initialIndex: index,
    ).show();
  }
}
