import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/router/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.foodEntity,
    this.onTap,
    this.height,
  });

  final FoodEstablishmentEntity foodEntity;
  final VoidCallback? onTap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap ??
          () {
            context.pushNamed(AppRoutes.food.name,
                pathParameters: {"id": foodEntity.id.toString()});
          },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.darkerGreyFont),
          borderRadius: BorderRadius.circular(
            25,
          ),
          image: foodEntity.place.photos.isNotEmpty
              ? DecorationImage(
                  image: CachedNetworkImageProvider(
                    foodEntity.place.photos.first.image,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        height: height,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_outline),
                ),
              ),
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
}
