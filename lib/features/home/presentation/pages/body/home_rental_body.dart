import 'package:carousel_slider/carousel_slider.dart';
import 'package:vill_finder/core/common/widgets/view_all_btn.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_rental/home_rental_bloc.dart';
import 'package:vill_finder/features/home/presentation/widgets/business/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';

class HomeRentalBody extends StatelessWidget {
  const HomeRentalBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: BlocBuilder<HomeRentalBloc, HomeRentalState>(
        builder: (context, state) {
          if (state is HomeRentalFailure) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is HomeRentalSuccess) {
            if (state.featureRentals.results.isEmpty &&
                state.nonFeatureRentals.results.isEmpty) {
              return Center(
                child: Text(
                  'No result, try different keyword.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: ColorName.darkerGreyFont,
                  ),
                ),
              );
            }

            return Column(
              children: [
                rentalCarousel(
                  rentals: state.featureRentals.results,
                  textTheme: textTheme,
                  title: 'Featured Rentals',
                  onTapViewAll: () {},
                ),
                const SizedBox(height: 15),
                rentalCarousel(
                  rentals: state.nonFeatureRentals.results,
                  textTheme: textTheme,
                  title: state.featureRentals.results.isEmpty
                      ? 'Rentals'
                      : 'Other Rentals',
                  onTapViewAll: () {},
                ),
              ],
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const ShimmerLoading(
                  width: double.infinity,
                  height: 50,
                );
              }

              return const ShimmerLoading(
                width: double.infinity,
                height: 124,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            itemCount: 4,
          );
        },
      ),
    );
  }

  Widget rentalCarousel({
    required TextTheme textTheme,
    required List<RentalEntity> rentals,
    required String title,
    required VoidCallback onTapViewAll,
  }) {
    if (rentals.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textTheme.labelMedium,
                ),
                ViewAllBtn(
                  onPressed: onTapViewAll,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 7.5),
        CarouselSlider.builder(
          options: CarouselOptions(
            enableInfiniteScroll: rentals.length > 1,
            autoPlay: false,
            enlargeCenterPage: false,
            viewportFraction: rentals.length > 1 ? 0.75 : 1,
            aspectRatio: 2,
            height: 175,
          ),
          itemCount: rentals.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: RentalCard(
              rentalEntity: rentals[itemIndex],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
