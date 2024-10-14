// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vill_finder/features/food/presentation/pages/widgets/food_hosted.dart';

import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/rental/presentation/widgets/index.dart';
import 'package:vill_finder/features/review/presentation/body/review_list.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class FoodBody extends StatelessWidget {
  const FoodBody({
    super.key,
    required this.food,
  });

  final FoodEstablishmentEntity food;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textDefaultStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: ColorName.blackFont,
        );
    final photos = food.place.photos;
    final place = food.place;
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          child: CarouselSlider.builder(
            options: CarouselOptions(
              enableInfiniteScroll: photos.length > 1,
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 1.2,
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            itemCount: photos.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                width: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: photos[itemIndex].image,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place.name,
                style: textTheme.headlineMedium
                    ?.copyWith(color: ColorName.blackFont),
              ),
              const SizedBox(height: 10),
              Text(
                place.address,
                style: textDefaultStyle,
              ),
              const SizedBox(height: 5.5),
              const SizedBox(height: 10),
              const Divider(height: 30, color: ColorName.borderColor),
              FoodHosted(
                host: food.place.userProfile,
              ),
              const Divider(height: 30, color: ColorName.borderColor),
              Text(
                food.place.description,
                style: textTheme.bodySmall,
              ),
              const Divider(height: 30, color: ColorName.borderColor),
              PreviewLocation(
                place: food.place,
              ),
              const Divider(height: 30, color: ColorName.borderColor),
              const ReviewList(),
              const Divider(height: 30, color: ColorName.borderColor),
            ],
          ),
        )
      ],
    );
  }
}
