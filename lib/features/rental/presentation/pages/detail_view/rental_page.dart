import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:vill_finder/core/common/widgets/loader.dart';
import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/enum/view_status.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/favorite/presentation/bloc/rental_favorite_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_rental/home_rental_bloc.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental/rental_bloc.dart';
import 'package:vill_finder/features/rental/presentation/pages/body/rental_body.dart';
import 'package:vill_finder/features/review/presentation/bloc/review_list_bloc.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({super.key});

  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  final reviewCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: buildAppbar(),
      body: BlocConsumer<RentalBloc, RentalState>(
        listener: blocListener,
        builder: (context, state) {
          if (state is RentalLoading) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ShimmerLoading(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.45,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Divider(
                              height: 30, color: ColorName.borderColor),
                          ShimmerLoading(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          const Divider(
                              height: 30, color: ColorName.borderColor),
                          ShimmerLoading(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          const Divider(
                              height: 30, color: ColorName.borderColor),
                          ShimmerLoading(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
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
            return SingleChildScrollView(
              child: RentalBody(
                rental: state.rental,
                controller: reviewCtrl,
                onChangeTapGallery: (index) {
                  handleOpenGallery(remoteImages: [
                    ...state.rental.place.photos.map(
                      (e) => CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: e.image,
                      ),
                    )
                  ], index: index);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  PreferredSizeWidget buildAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight) * 0.75,
      child: BlocBuilder<RentalBloc, RentalState>(
        builder: (context, state) {
          final isLoaded = state is RentalSuccess;

          return AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
              ),
            ),
            actions: isLoaded
                ? [
                    GestureDetector(
                      onTap: () {
                        handleOnTapFavorite(state.rental.place.isFavorited);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          state.rental.place.isFavorited
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ]
                : null,
          );
        },
      ),
    );
  }

  Widget iconWithText({
    required String title,
    required IconData iconData,
  }) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 15,
          color: ColorName.darkerGreyFont,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: ColorName.blackFont,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ].withSpaceBetween(width: 3),
    );
  }

  void blocListener(BuildContext context, RentalState state) {
    if (state is RentalSuccess) {
      if (state.viewStatus == ViewStatus.loading) {
        LoadingScreen.instance().show(context: context);
      }

      if (state.viewStatus == ViewStatus.successful ||
          state.viewStatus == ViewStatus.failed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          LoadingScreen.instance().hide();
        }).whenComplete(() {
          final message = state.viewStatus == ViewStatus.successful
              ? state.successMessage ?? ""
              : "Something went wrong";

          if (message.isNotEmpty) {
            onFormDisplayMessage(message);
          }
          context.read<HomeRentalListBloc>().add(
                UpdateHomeFavoriteRentalEvent(
                  id: state.rental.id,
                  value: state.rental.place.isFavorited,
                ),
              );
          context.read<RentalFavoriteBloc>().add(GetFavoriteEvent());

          context.read<ReviewListBloc>().add(GetReviewsEvent(
              placeId: state.rental.id, reviewType: ReviewType.rental));
        });
      }
    }
  }

  void onFormDisplayMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void handleOnTapFavorite(bool isFavorited) {
    context.read<RentalBloc>().add(
        isFavorited ? RemoveFavoriteRentalEvent() : AddFavoriteRentalEvent());
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
