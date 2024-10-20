import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/common/cubit/app_user_cubit.dart';
import 'package:vill_finder/core/common/widgets/shimmer_loading.dart';
import 'package:vill_finder/core/router/app_routes.dart';
import 'package:vill_finder/features/favorite/presentation/bloc/rental_favorite_bloc.dart';
import 'package:vill_finder/features/home/presentation/widgets/business/index.dart';
import 'package:vill_finder/gen/assets.gen.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    final state = context.read<AppUserCubit>().state;
    if (state is AppUserLoggedIn) {
      context.read<RentalFavoriteBloc>().add(GetFavoriteEvent());
    }

    handleEventScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Favorites',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AppUserCubit, AppUserState>(
        builder: (context, state) {
          if (state is AppUserLoggedIn) {
            return BlocBuilder<RentalFavoriteBloc, RentalFavoriteState>(
              builder: (context, state) {
                if (state is RentalFavoriteLoading) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
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
                        ),
                      ),
                    ],
                  );
                }

                if (state is RentalFavoriteFailure) {
                  return const Center(
                    child: Text(
                      'Something went wrong in our server, please try again later.',
                    ),
                  );
                }

                if (state is RentalFavoriteSuccess) {
                  if (state.favorites.results.isEmpty) {
                    return Column(
                      children: [
                        Assets.lottie.emptyFavorite.lottie(),
                        const Text(
                          'Add your favorites ♥',
                        )
                      ],
                    );
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: RefreshIndicator(
                            onRefresh: () {
                              context
                                  .read<RentalFavoriteBloc>()
                                  .add(GetFavoriteEvent());
                              return Future.value();
                            },
                            child: ListView.separated(
                              controller: controller,
                              itemBuilder: (context, index) {
                                final item = state.favorites.results[index];

                                return RentalCard(
                                  height: 175,
                                  rentalEntity: item,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount: state.favorites.results.length,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            );
          }

          return Column(
            children: [
              Assets.lottie.emptyFavorite.lottie(),
              TextButton(
                onPressed: () {
                  context.go(AppRoutes.login.path);
                },
                child: const Text('Please login to continue'),
              ),
            ],
          );
        },
      ),
    );
  }

  void handleEventScrollListener() {
    controller.addListener(() {
      if (controller.position.pixels > (controller.position.pixels * 0.75)) {
        context.read<RentalFavoriteBloc>().add(PaginateFavoriteEvent());
      }
    });
  }
}
