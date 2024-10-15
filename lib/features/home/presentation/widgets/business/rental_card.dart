import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/router/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';
import 'package:vill_finder/features/navigation/presentation/cubit/navigator_index_cubit.dart';
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
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.darkerGreyFont),
          borderRadius: BorderRadius.circular(
            10,
          ),
          image: rentalEntity.place.photos.isNotEmpty
              ? DecorationImage(
                  image: CachedNetworkImageProvider(
                    rentalEntity.place.photos.first.image,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        height: height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    onFormDisplayMessage(
                        context: context,
                        message: 'This feature is not yet implemented');
                  },
                  icon: const Icon(Icons.favorite_outline),
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
                        style: textTheme.labelMedium,
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
            )
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
