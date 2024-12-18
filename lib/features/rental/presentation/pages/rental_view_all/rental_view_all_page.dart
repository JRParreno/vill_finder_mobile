import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/features/home/presentation/widgets/business/index.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental_list_bloc/rental_list_bloc.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class RentalViewAllPage extends StatefulWidget {
  const RentalViewAllPage({super.key});

  @override
  State<RentalViewAllPage> createState() => _RentalViewAllPageState();
}

class _RentalViewAllPageState extends State<RentalViewAllPage> {
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
          'Rental(s)',
          style: textTheme.titleLarge?.copyWith(
            fontSize: 24,
            color: ColorName.blackFont,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<RentalListBloc, RentalListState>(
        builder: (context, state) {
          if (state is RentalListLoading) {
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

          if (state is RentalListFailure) {
            return const Expanded(
              child: Center(
                child: Text(
                  'Something went wrong in our server, please try again later.',
                ),
              ),
            );
          }

          if (state is RentalListSuccess) {
            final search = state.search;
            return Column(
              children: [
                Expanded(
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

                              return RentalCard(
                                height: 175,
                                rentalEntity: item,
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
                ),
              ],
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
        context.read<RentalListBloc>().add(GetRentalListPaginateEvent());
      }
    });
  }
}
