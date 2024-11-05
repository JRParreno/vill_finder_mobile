// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:vill_finder/core/enum/view_status.dart';
import 'package:vill_finder/features/home/presentation/blocs/cubit/cubit/category_cubit.dart';
import 'package:vill_finder/features/map/domain/usecase/get_business_map_list.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: SizedBox(
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: ColorName.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 40),
                        child: Text(
                          'Filter by Category',
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (state.viewStatus == ViewStatus.loading) ...[
                        const Expanded(
                          child: Text('Getting please wait'),
                        ),
                      ],
                      if (state.viewStatus == ViewStatus.successful &&
                          state.categories != null &&
                          state.categories!.results.isNotEmpty) ...[
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    ...state.categories!.results.map(
                                      (e) {
                                        return ListTile(
                                          enableFeedback: true,
                                          trailing: state.filteredCategories
                                                  .contains(e)
                                              ? const Icon(Icons.check)
                                              : null,
                                          title: Text(e.name),
                                          selected: state.filteredCategories
                                              .contains(e),
                                          onTap: () {
                                            context
                                                .read<CategoryCubit>()
                                                .onSelect(e);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                enableFeedback: true,
                                title:
                                    const Center(child: Text('Apply Filter')),
                                onTap: () {
                                  context.read<MapBusinessBloc>().add(
                                        GetMapBusinessEvent(
                                            GetBusinessMapListParams(
                                          name: text,
                                        )),
                                      );
                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {
                                    context.pop();
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
