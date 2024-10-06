import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/core/extension/spacer_widgets.dart';
import 'package:vill_finder/features/home/presentation/blocs/search/search_bloc.dart';
import 'package:vill_finder/features/home/presentation/pages/search/body/index.dart';
import 'package:vill_finder/features/home/presentation/pages/search/widgets/index.dart';
import 'package:vill_finder/features/home/presentation/widgets/search_field.dart';
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
    context.read<SearchBloc>().add(SearchGetRecentSearches());
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
                      context.read<SearchBloc>().add(
                            SearchTriggerEvent(
                              searchCtrl.text,
                            ),
                          );
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              BlocConsumer<SearchBloc, SearchState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is SearchLoading) {
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

                  if (state is SearchEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'Sorry, No result found :(',
                        ),
                      ),
                    );
                  }

                  if (state is SearchFailure) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'Something went wrong in our server, please try again later.',
                        ),
                      ),
                    );
                  }

                  if (state is SearchRecentLoaded) {
                    return RecentSearches(
                      keywords: state.keywords,
                      onClearRecent: () {
                        context
                            .read<SearchBloc>()
                            .add(SearchClearRecentSearches());
                      },
                      onTapKeyword: (String value) {
                        searchCtrl.text = value;
                        setState(() {});
                      },
                    );
                  }

                  if (state is SearchSuccess) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SearchRentalList(
                              onTapViewAll: () {},
                              rentals: state.rentals!.results,
                            ),
                            if (state.rentals!.results.isNotEmpty)
                              const Divider(
                                color: ColorName.placeholder,
                                thickness: 2,
                                height: 5,
                              ),
                            SearchFoodList(
                              onTapViewAll: () {},
                              foods: state.foods!.results,
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
