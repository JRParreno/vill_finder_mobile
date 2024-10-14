// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/rental/presentation/widgets/index.dart';
import 'package:vill_finder/features/review/presentation/body/review_list.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class RentalBody extends StatelessWidget {
  const RentalBody({
    super.key,
    required this.rental,
  });

  final RentalEntity rental;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textDefaultStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: ColorName.blackFont,
        );
    final PlaceEntity place = rental.place;
    final photos = rental.place.photos;

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
                'PHP ${rental.monthlyRent} / ${rental.leaseTerm.replaceAll('_', ' ').toLowerCase()}',
                style: textTheme.headlineMedium
                    ?.copyWith(color: ColorName.blackFont, fontSize: 17),
              ),
              const SizedBox(height: 10),
              Text(
                place.address,
                style: textDefaultStyle,
              ),
              const SizedBox(height: 5.5),
              Text(
                rental.propertyType,
                style: textDefaultStyle,
              ),
              const SizedBox(height: 5.5),
              Row(
                children: [
                  Text(
                    rental.numBedrooms > 0
                        ? '${rental.numBedrooms} beds'
                        : 'Studio type',
                    style: textDefaultStyle,
                  ),
                  if (rental.numBathrooms > 0 && rental.numBathrooms > 0) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        '•',
                        style: textDefaultStyle,
                      ),
                    ),
                  ],
                  if (rental.numBathrooms > 0) ...[
                    Text(
                      '${rental.numBathrooms} baths',
                      style: textDefaultStyle,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              const Divider(height: 30, color: ColorName.borderColor),
              HostedBy(
                host: rental.place.userProfile,
              ),
              const Divider(height: 30, color: ColorName.borderColor),
              Text(
                rental.place.description,
                style: textTheme.bodySmall,
              ),
              const Divider(height: 30, color: ColorName.borderColor),
              RentalCondition(
                furnitureCondition: rental.furnitureCondition,
                propertyCondition: rental.propertyCondition,
              ),
              const Divider(height: 30, color: ColorName.borderColor),
              Amenities(
                rental: rental,
              ),
              const Divider(height: 30, color: ColorName.borderColor),
              PreviewLocation(
                place: rental.place,
              ),
              const Divider(height: 30, color: ColorName.borderColor),
              const ReviewList(),
              const Divider(height: 30, color: ColorName.borderColor),
            ],
          ),
        ),
      ],
    );
  }
}
