// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/mixins/app_check.dart';
import 'package:vill_finder/core/router/app_routes.dart';

import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/rental/presentation/widgets/index.dart';
import 'package:vill_finder/features/review/presentation/bloc/cubit/review_star_cubit.dart';
import 'package:vill_finder/features/review/presentation/body/review_form.dart';
import 'package:vill_finder/features/review/presentation/body/review_list.dart';
import 'package:vill_finder/gen/assets.gen.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class RentalBody extends StatelessWidget with AppCheck {
  const RentalBody({
    super.key,
    required this.rental,
    required this.controller,
    required this.onChangeTapGallery,
    this.isModalView = false,
  });

  final RentalEntity rental;
  final TextEditingController controller;
  final Function(int index) onChangeTapGallery;
  final bool isModalView;

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
                    GestureDetector(
              onTap: () {
                onChangeTapGallery(itemIndex);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  width: double.infinity,
                  child: CachedNetworkImage(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: photos[itemIndex].image,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Assets.images.placeholder.imagePlaceholder.image(),
                  ),
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
                  if (rental.numBedrooms > 0) ...[
                    Text(
                      '${rental.numBedrooms} beds',
                      style: textDefaultStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        '•',
                        style: textDefaultStyle,
                      ),
                    ),
                    Text(
                      '${rental.availableBedrooms} available beds',
                      style: textDefaultStyle,
                    ),
                  ] else ...[
                    Text(
                      'Studio type',
                      style: textDefaultStyle,
                    ),
                  ],
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
                contactNumber: rental.place.contactNumber,
                contactName: rental.place.contactName,
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
              ReviewList(
                totalReview: place.totalReview,
                averageReview: place.averageReview,
              ),
              const Divider(height: 30, color: ColorName.borderColor),
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorName.placeholder,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: isUserLogged(context)
                      ? GestureDetector(
                          onTap: () {
                            if (isModalView) {
                              context.pushNamed(AppRoutes.rental.name,
                                  pathParameters: {"id": rental.id.toString()});
                              return;
                            }

                            controller.text =
                                rental.place.reviewEntity?.comment ?? '';
                            context.read<ReviewStarCubit>().onChangeStars(
                                double.parse(rental.place.reviewEntity?.stars
                                        .toString() ??
                                    "0"));
                            addFeedbackBottomSheetDialog(
                              id: rental.id,
                              context: context,
                              controller: controller,
                              place: place,
                              reviewType: ReviewType.rental,
                              reviewId: rental.place.reviewEntity?.id,
                            );
                          },
                          child: Text(
                            '${rental.place.userHasReviewed ? 'Edit' : 'Add'} your review',
                            style: textTheme.bodySmall?.copyWith(
                              color: ColorName.blackFont,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => handleOnTapLogin(context),
                          child: Text(
                            'To add review please login first',
                            style: textTheme.bodySmall?.copyWith(
                              color: ColorName.blackFont,
                            ),
                          ),
                        ),
                ),
              ),
              const Divider(height: 30, color: ColorName.borderColor),
            ],
          ),
        ),
      ],
    );
  }

  void handleOnTapLogin(BuildContext context) {
    context.go(AppRoutes.login.path);
  }
}
