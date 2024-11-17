import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:vill_finder/core/common/widgets/loader.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/enum/view_status.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/food/presentation/blocs/food/food_bloc.dart';
import 'package:vill_finder/features/food/presentation/pages/body/food_body.dart';
import 'package:vill_finder/features/food/presentation/pages/body/food_loading.dart';
import 'package:vill_finder/features/review/presentation/bloc/review_list_bloc.dart';
import 'package:vill_finder/gen/assets.gen.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        listener: blocListener,
        builder: (context, state) {
          if (state is FoodLoading) {
            return const FoodLoadingWidget();
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
            return SingleChildScrollView(
              child: FoodBody(
                controller: controller,
                food: state.food,
                onChangeTapGallery: (index) {
                  handleOpenGallery(remoteImages: [
                    ...state.food.place.photos.map(
                      (e) => CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: e.image,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Assets.images.placeholder.imagePlaceholder.image(),
                      ),
                    )
                  ], index: index);
                },
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

  void blocListener(BuildContext context, FoodState state) {
    if (state is FoodSuccess) {
      if (state.viewStatus == ViewStatus.loading) {
        LoadingScreen.instance().show(context: context);
      }

      if (state.viewStatus == ViewStatus.successful ||
          state.viewStatus == ViewStatus.failed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          LoadingScreen.instance().hide();
        }).whenComplete(() {
          final message = state.viewStatus == ViewStatus.successful
              ? state.successMessage ?? ""
              : "Something went wrong";

          if (message.isNotEmpty) {
            onFormDisplayMessage(message);
          }

          context.read<ReviewListBloc>().add(GetReviewsEvent(
              placeId: state.food.id,
              reviewType: ReviewType.foodestablishment));
        });
      }
    }
  }

  void onFormDisplayMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void handleOpenGallery({
    required List<Widget> remoteImages,
    required int index,
  }) {
    SwipeImageGallery(
      context: context,
      children: remoteImages,
      initialIndex: index,
    ).show();
  }
}
