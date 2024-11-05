import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/core/enum/view_status.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/core/router/index.dart';
import 'package:vill_finder/features/home/presentation/blocs/cubit/cubit/category_cubit.dart';
import 'package:vill_finder/features/home/presentation/pages/search/body/index.dart';
import 'package:vill_finder/features/home/presentation/pages/search/widgets/index.dart';
import 'package:vill_finder/features/home/presentation/widgets/search_field.dart';
import 'package:vill_finder/features/map/domain/usecase/get_business_map_list.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';
import 'package:vill_finder/gen/colors.gen.dart';

class HomeSearchPage extends StatefulWidget {
  const HomeSearchPage({super.key});

  @override
  State<HomeSearchPage> createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  final TextEditingController searchCtrl = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<MapBusinessBloc>().add(GetRecentSearches());
    if (context.read<CategoryCubit>().state.viewStatus == ViewStatus.none) {
      context.read<CategoryCubit>().getCategoryList();
    } else {
      context.read<CategoryCubit>().resetFilters();
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: textTheme.titleLarge?.copyWith(
            fontSize: 24,
            color: ColorName.blackFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: FilterDrawer(
        text: searchCtrl.text,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchField(
                onChanged: () {
                  setState(() {});
                },
                onClearText: () {
                  searchCtrl.clear();
                  setState(() {});
                },
                controller: searchCtrl,
                hintText: 'Search',
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: ColorName.darkerGreyFont,
                ),
                onSubmit: () {
                  if (searchCtrl.text.trim().isNotEmpty) {
                    FocusScope.of(context).unfocus();

                    Future.delayed(
                        const Duration(
                          milliseconds: 500,
                        ), () {
                      context.read<MapBusinessBloc>().add(
                            GetMapBusinessEvent(GetBusinessMapListParams(
                              name: searchCtrl.value.text,
                            )),
                          );
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              BlocConsumer<MapBusinessBloc, MapBusinessState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is MapBusinessLoading) {
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

                  if (state is MapBusinessEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'Sorry, No result found :(',
                        ),
                      ),
                    );
                  }

                  if (state is MapBusinessFailure) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'Something went wrong in our server, please try again later.',
                        ),
                      ),
                    );
                  }

                  if (state is MapBusinessRecentLoaded) {
                    return RecentSearches(
                      keywords: state.keywords,
                      onClearRecent: () {
                        context
                            .read<MapBusinessBloc>()
                            .add(ClearRecentSearches());
                      },
                      onTapKeyword: (String value) {
                        searchCtrl.text = value;
                        setState(() {});
                      },
                    );
                  }

                  if (state is MapBusinessSuccess) {
                    final rentals = state.data.results.rentals;
                    final foods = state.data.results.foods;

                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SearchRentalList(
                              onTapViewAll: () {
                                context.pushNamed(
                                  AppRoutes.rentalViewAll.name,
                                  extra: {
                                    "data": rentals,
                                    "search": searchCtrl.value.text,
                                  },
                                );
                              },
                              rentals: rentals,
                            ),
                            if (rentals.isNotEmpty)
                              const Divider(
                                color: ColorName.placeholder,
                                thickness: 2,
                                height: 5,
                              ),
                            SearchFoodList(
                              onTapViewAll: () {
                                context.pushNamed(
                                  AppRoutes.foodViewAll.name,
                                  extra: {
                                    "data": foods,
                                    "search": searchCtrl.value.text,
                                  },
                                );
                              },
                              foods: foods,
                            ),
                          ].withSpaceBetween(height: 20),
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
