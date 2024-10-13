import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/food/presentation/blocs/food/food_bloc.dart';
import 'package:vill_finder/features/food/presentation/pages/widgets/food_hosted.dart';
import 'package:vill_finder/features/rental/presentation/widgets/index.dart';
import 'package:vill_finder/features/review/presentation/body/review_list.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textDefaultStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: ColorName.blackFont,
        );
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back,
              size: 20,
            ),
          ),
        ),
      ),
      body: BlocConsumer<FoodBloc, FoodState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is FoodLoading) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ShimmerLoading(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.45,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const Divider(
                              height: 30, color: ColorName.borderColor),
                          ShimmerLoading(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          const Divider(
                              height: 30, color: ColorName.borderColor),
                          ShimmerLoading(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          const Divider(
                              height: 30, color: ColorName.borderColor),
                          ShimmerLoading(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          if (state is FoodFailure) {
            return const Expanded(
              child: Center(
                child: Text(
                  'Something went wrong in our server, please try again later.',
                ),
              ),
            );
          }

          if (state is FoodSuccess) {
            final photos = state.food.place.photos;
            final place = state.food.place;
            return SingleChildScrollView(
              child: Column(
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
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
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
                          host: state.food.place.userProfile,
                        ),
                        const Divider(height: 30, color: ColorName.borderColor),
                        Text(
                          state.food.place.description,
                          style: textTheme.bodySmall,
                        ),
                        const Divider(height: 30, color: ColorName.borderColor),
                        PreviewLocation(
                          place: state.food.place,
                        ),
                        const Divider(height: 30, color: ColorName.borderColor),
                        const ReviewList(),
                        const Divider(height: 30, color: ColorName.borderColor),
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget iconWithText({
    required String title,
    required IconData iconData,
  }) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 15,
          color: ColorName.darkerGreyFont,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: ColorName.blackFont,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ].withSpaceBetween(width: 3),
    );
  }
}
