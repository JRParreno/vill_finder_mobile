// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/core/mixins/app_check.dart';
import 'package:vill_finder/core/router/app_routes.dart';
import 'package:vill_finder/features/food/presentation/pages/widgets/food_hosted.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/rental/presentation/widgets/index.dart';
import 'package:vill_finder/features/review/presentation/body/review_form.dart';
import 'package:vill_finder/features/review/presentation/body/review_list.dart';
import 'package:vill_finder/gen/assets.gen.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class FoodBody extends StatelessWidget with AppCheck {
  const FoodBody({
    super.key,
    required this.food,
    required this.controller,
    required this.onChangeTapGallery,
    this.isModalView = false,
  });

  final FoodEstablishmentEntity food;
  final TextEditingController controller;
  final Function(int index) onChangeTapGallery;
  final bool isModalView;

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
                  ), // Custom error image
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
              getTimeDisplay(
                openingTime: food.openingTime,
                closingTime: food.closingTime,
                textDefaultStyle: textDefaultStyle,
                isOpen24Hours: food.isOpen24Hours,
              ),
              const SizedBox(height: 10),
              const Divider(height: 30, color: ColorName.borderColor),
              FoodHosted(
                host: food.place.userProfile,
                contactName: food.place.contactName,
                contactNumber: food.place.contactNumber,
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
              ReviewList(
                totalReview: place.totalReview,
                sentimentLabel: place.sentimentLabel,
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
                              context.pushNamed(AppRoutes.food.name,
                                  pathParameters: {"id": food.id.toString()});
                              return;
                            }

                            controller.text =
                                food.place.reviewEntity?.comment ?? '';
                            addFeedbackBottomSheetDialog(
                              id: food.id,
                              context: context,
                              controller: controller,
                              place: place,
                              reviewType: ReviewType.foodestablishment,
                              reviewId: food.place.reviewEntity?.id,
                            );
                          },
                          child: Text(
                            '${food.place.userHasReviewed ? 'Edit' : 'Add'} your review',
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
        )
      ],
    );
  }

  void handleOnTapLogin(BuildContext context) {
    context.go(AppRoutes.login.path);
  }

  Widget getTimeDisplay({
    required String openingTime,
    required String closingTime,
    bool isOpen24Hours = false,
    TextStyle? textDefaultStyle,
  }) {
    // Parse the time string into a DateTime object
    DateTime openTime = DateFormat("HH:mm").parse(openingTime);
    DateTime closeTime = DateFormat("HH:mm").parse(closingTime);

    // Format the DateTime object into the desired 12-hour format
    String formattedOpenTime = DateFormat.jm().format(openTime);
    String formattedCloseTime = DateFormat.jm().format(closeTime);

    return Row(
      children: [
        const Icon(Icons.access_time, size: 15),
        Text(
          isOpen24Hours
              ? "Open 24hrs"
              : "$formattedOpenTime - $formattedCloseTime",
          style: textDefaultStyle,
        ),
      ].withSpaceBetween(width: 3),
    );
  }
}
