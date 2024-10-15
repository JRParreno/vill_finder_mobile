import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/food/presentation/blocs/food/food_bloc.dart';
import 'package:vill_finder/features/food/presentation/pages/body/food_body.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
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
      body: BlocBuilder<FoodBloc, FoodState>(
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
            return SingleChildScrollView(
              child: FoodBody(
                food: state.food,
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
