import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/router/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';
import 'package:vill_finder/features/navigation/presentation/cubit/navigator_index_cubit.dart';
import 'package:vill_finder/gen/assets.gen.dart';
import 'package:vill_finder/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class RentalCard extends StatelessWidget {
  const RentalCard({
    super.key,
    required this.rentalEntity,
    this.onTap,
    this.height,
    this.isHome = false,
  });

  final RentalEntity rentalEntity;
  final VoidCallback? onTap;
  final double? height;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap ??
          () {
            if (isHome) {
              context.pushNamed(
                AppRoutes.rental.name,
                pathParameters: {"id": rentalEntity.id.toString()},
              );
              return;
            }

            final currentIndex =
                context.read<NavigatorIndexCubit>().state.currentIndex;
            context
                .read<MapBusinessBloc>()
                .add(TapSearchResultEvent(rental: rentalEntity));
            if (currentIndex == 2) {
              context.pop();
            } else {
              context.read<NavigatorIndexCubit>().onChangeIndex(2);
            }
          },
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.darkerGreyFont),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            // CachedNetworkImage as the background
            rentalEntity.place.photos.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      imageUrl: rentalEntity.place.photos.first.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                          child:
                              CircularProgressIndicator()), // Optional placeholder
                      errorWidget: (context, url, error) =>
                          Assets.images.placeholder.imagePlaceholder.image(
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ), // Error widget
                    ),
                  )
                : Container(), // Empty container if no photos are available

            // Your existing column content stays on top of the image
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        rentalEntity.place.isFavorited
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: rentalEntity.place.isFavorited
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rentalEntity.place.name,
                            style: textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            rentalEntity.place.address,
                            style: textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getTimeAgo(DateTime taskDate) {
    final fifteenAgo = DateTime.now().subtract(Duration(
        hours: taskDate.hour,
        minutes: taskDate.minute,
        seconds: taskDate.second));
    return timeago.format(fifteenAgo);
  }

  void onFormDisplayMessage({
    required String message,
    required BuildContext context,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
