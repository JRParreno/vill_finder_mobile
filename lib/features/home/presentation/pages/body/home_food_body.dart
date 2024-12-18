import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/common/widgets/view_all_btn.dart';
import 'package:vill_finder/core/router/index.dart';
import 'package:vill_finder/features/home/presentation/blocs/cubit/carousel_dots_cubit.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_food/home_food_bloc.dart';
import 'package:vill_finder/features/home/presentation/widgets/business/dots_indicator.dart';
import 'package:vill_finder/features/home/presentation/widgets/business/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';

class HomeFoodBody extends StatelessWidget {
  const HomeFoodBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
      child: BlocBuilder<HomeFoodListBloc, HomeFoodListState>(
        builder: (context, state) {
          if (state is HomeFoodFailure) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is HomeFoodSuccess) {
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
                context
                    .read<HomeFoodListBloc>()
                    .add(RefreshHomeFoodListEvent());
                return Future<void>.value();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.25,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      aspectRatio: 2,
                      onPageChanged: (index, reason) {
                        context.read<DotsCubit>().updateIndex(index);
                      },
                    ),
                    itemCount: state.data.results.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        FoodCard(
                      isHome: true,
                      foodEntity: state.data.results[itemIndex],
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (state.data.results.length > 1) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<DotsCubit, DotsState>(
                          builder: (context, dotState) {
                            return DotsIndicator(
                              itemCount: state.data.results.length,
                              currentIndex: dotState.currentIndex,
                            );
                          },
                        ),
                        if (state.data.count > 10)
                          ViewAllBtn(
                            onPressed: () {
                              context.pushNamed(
                                AppRoutes.foodViewAll.name,
                                extra: {
                                  "data": state.data,
                                  "search": '',
                                },
                              );
                            },
                          ),
                      ],
                    ),
                  ]
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
