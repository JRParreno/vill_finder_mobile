import 'package:cached_network_image/cached_network_image.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class BusinessCard extends StatelessWidget {
  const BusinessCard({
    super.key,
    required this.business,
    this.onTap,
  });

  final BusinessEntity business;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width * 0.75;

    return GestureDetector(
      onTap: onTap ??
          () {
            // TODO detail business
          },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.darkerGreyFont),
          borderRadius: BorderRadius.circular(
            10,
          ),
          image: business.businessPhotos.isNotEmpty
              ? DecorationImage(
                  image: CachedNetworkImageProvider(
                    business.businessPhotos.first.image,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        height: width,
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
                  onPressed: () {},
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
                        business.name,
                        style: textTheme.labelMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        business.address,
                        style: textTheme.labelSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
}
