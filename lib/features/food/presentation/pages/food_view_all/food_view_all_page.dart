import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/features/food/presentation/blocs/food_list_bloc/food_list_bloc.dart';
import 'package:vill_finder/features/home/presentation/widgets/business/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class FoodViewAllPage extends StatefulWidget {
  const FoodViewAllPage({super.key});

  @override
  State<FoodViewAllPage> createState() => _FoodViewAllPageState();
}

class _FoodViewAllPageState extends State<FoodViewAllPage> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Establishment(s)',
          style: textTheme.titleLarge?.copyWith(
            fontSize: 24,
            color: ColorName.blackFont,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<FoodListBloc, FoodListState>(
        builder: (context, state) {
          if (state is FoodLoading) {
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
            final search = state.search;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (search != null && search.isNotEmpty)
                      Text(
                        'Search: ${state.search}',
                        style: textTheme.labelSmall?.copyWith(
                          color: ColorName.darkerGreyFont,
                        ),
                      ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                        controller: controller,
                        itemBuilder: (context, index) {
                          final item = state.data.results[index];

                          return FoodCard(
                            height: 175,
                            foodEntity: item,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: state.data.results.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void handleEventScrollListener() {
    controller.addListener(() {
      if (controller.position.pixels > (controller.position.pixels * 0.75)) {
        context.read<FoodListBloc>().add(GetFoodPaginateEvent());
      }
    });
  }
}
