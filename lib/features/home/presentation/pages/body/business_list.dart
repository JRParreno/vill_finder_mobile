import 'package:vill_finder/features/home/presentation/blocs/home_business/home_business_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_business_category/home_business_category_bloc.dart';
import 'package:vill_finder/features/home/presentation/widgets/business/index.dart';
import 'package:vill_finder/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';

class BusinessList extends StatelessWidget {
  const BusinessList({
    super.key,
    required this.controller,
  });

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: BlocBuilder<HomeBusinessBloc, HomeBusinessState>(
        builder: (context, state) {
          if (state is HomeBusinessFailure) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is HomeBusinessSuccess) {
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
                    .read<HomeBusinessBloc>()
                    .add(RefreshHomeBusinessEvent());
                context
                    .read<HomeBusinessCategoryBloc>()
                    .add(GetHomeBusinessCategoryEvent());
                return Future<void>.value();
              },
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = state.data.results[index];

                  return BusinessCard(
                    business: item,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: state.data.results.length,
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const ShimmerLoading(
                width: double.infinity,
                height: 124,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            itemCount: 3,
          );
        },
      ),
    );
  }
}
