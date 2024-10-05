import 'package:carousel_slider/carousel_slider.dart';
import 'package:vill_finder/features/home/presentation/blocs/cubit/carousel_dots_cubit.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_rental/home_rental_bloc.dart';
import 'package:vill_finder/features/home/presentation/widgets/business/dots_indicator.dart';
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
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<HomeRentalBloc, HomeRentalState>(
        builder: (context, state) {
          if (state is HomeRentalFailure) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is HomeRentalSuccess) {
            if (state.data.results.isEmpty) {
              return Center(
                child: Text(
                  'No result, try different keyword.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: ColorName.darkerGreyFont,
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () {
                context.read<HomeRentalBloc>().add(RefreshHomeRentalEvent());

                return Future<void>.value();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.75,
                      aspectRatio: 2,
                      onPageChanged: (index, reason) {
                        context.read<DotsCubit>().updateIndex(index);
                      },
                    ),
                    itemCount: state.data.results.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        RentalCard(
                      rentalEntity: state.data.results[itemIndex],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (state.data.results.length > 1) ...[
                        BlocBuilder<DotsCubit, DotsState>(
                          builder: (context, dotState) {
                            return DotsIndicator(
                              itemCount: state.data.results.length,
                              currentIndex: dotState.currentIndex,
                            );
                          },
                        ),
                      ] else ...[
                        const SizedBox.shrink(),
                      ],
                      Text(
                        'Rentals',
                        style: textTheme.labelMedium,
                      ),
                    ],
                  )
                ],
              ),
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
}
