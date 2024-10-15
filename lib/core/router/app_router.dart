import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:vill_finder/core/common/cubit/app_user_cubit.dart';
import 'package:vill_finder/core/config/shared_prefences_keys.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/notifier/shared_preferences_notifier.dart';
import 'package:vill_finder/core/router/index.dart';
import 'package:vill_finder/features/auth/presentation/pages/login_page.dart';
import 'package:vill_finder/features/error_page/error_page.dart';
import 'package:vill_finder/features/favorite/presentation/favorite_page.dart';
import 'package:vill_finder/features/food/presentation/blocs/food/food_bloc.dart';
import 'package:vill_finder/features/food/presentation/blocs/food_list_bloc/food_list_bloc.dart';
import 'package:vill_finder/features/food/presentation/pages/detail_view/food_page.dart';
import 'package:vill_finder/features/food/presentation/pages/food_view_all/food_view_all_page.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/home/presentation/pages/home_page.dart';
import 'package:vill_finder/features/map/presentation/pages/map_page.dart';
import 'package:vill_finder/features/navigation/presentation/scaffold_with_bottom_nav.dart';
import 'package:vill_finder/features/on_boarding/on_boarding.dart';
import 'package:vill_finder/features/home/presentation/pages/search/home_search_page.dart';
import 'package:vill_finder/features/profile/presentation/pages/profile_page.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental/rental_bloc.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental_list_bloc/rental_list_bloc.dart';
import 'package:vill_finder/features/rental/presentation/pages/detail_view/rental_page.dart';
import 'package:vill_finder/features/rental/presentation/pages/rental_view_all/rental_view_all_page.dart';
import 'package:vill_finder/features/review/presentation/bloc/review_list_bloc.dart';

GoRouter routerConfig() {
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'mainNavigator');

  final shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorHomeKey');
  final shellNavigatorFavoriteKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorFavoriteKey');
  final shellNavigatorMapKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorMapKey');
  final shellNavigatorProfileKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellNavigatorProfileKey');

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoutes.onBoarding.path,
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    refreshListenable:
        GoRouterRefreshStream(GetIt.instance<AppUserCubit>().stream),
    redirect: (BuildContext context, GoRouterState state) async {
      final sharedPreferencesNotifier =
          GetIt.instance<SharedPreferencesNotifier>();
      final bool isOnBoarded = sharedPreferencesNotifier.getValue(
          SharedPreferencesKeys.isOnBoarded, false);
      final onBoardingPath = state.matchedLocation == AppRoutes.onBoarding.path;

      if (isOnBoarded && onBoardingPath) {
        return AppRoutes.home.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.onBoarding.path,
        name: AppRoutes.onBoarding.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const OnBoardingPage(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) => ScaffoldWithBottomNav(child: child),
        branches: [
          StatefulShellBranch(
            navigatorKey: shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: AppRoutes.home.path,
                name: AppRoutes.home.name,
                pageBuilder: (context, state) {
                  return buildTransitionPage(
                    localKey: state.pageKey,
                    child: const HomePage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorFavoriteKey,
            routes: [
              GoRoute(
                path: AppRoutes.favorite.path,
                name: AppRoutes.favorite.name,
                pageBuilder: (context, state) {
                  return buildTransitionPage(
                    localKey: state.pageKey,
                    child: const FavoritePage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorMapKey,
            routes: [
              GoRoute(
                path: AppRoutes.map.path,
                name: AppRoutes.map.name,
                pageBuilder: (context, state) {
                  return buildTransitionPage(
                    localKey: state.pageKey,
                    child: const MapPage(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: AppRoutes.profile.path,
                name: AppRoutes.profile.name,
                pageBuilder: (context, state) {
                  return buildTransitionPage(
                    localKey: state.pageKey,
                    child: const ProfilePage(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.homeSearch.path,
        name: AppRoutes.homeSearch.name,
        pageBuilder: (context, state) {
          return buildTransitionPage(
            localKey: state.pageKey,
            child: const HomeSearchPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.rentalViewAll.path,
        name: AppRoutes.rentalViewAll.name,
        pageBuilder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;

          context.read<RentalListBloc>().add(
                SetRentalListStateEvent(
                  data: extra['data'] as RentalListResponseEntity,
                  search: extra['search'],
                ),
              );

          return buildTransitionPage(
            localKey: state.pageKey,
            child: const RentalViewAllPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.foodViewAll.path,
        name: AppRoutes.foodViewAll.name,
        pageBuilder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;

          context.read<FoodListBloc>().add(
                SetFoodListStateEvent(
                  data: extra['data'] as FoodEstablishmentListResponseEntity,
                  search: extra['search'],
                ),
              );

          return buildTransitionPage(
            localKey: state.pageKey,
            child: const FoodViewAllPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.rental.path,
        name: AppRoutes.rental.name,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'];

          context.read<RentalBloc>().add(
                GetRentalEvent(int.parse(id!)),
              );
          context.read<ReviewListBloc>().add(
                GetReviewsEvent(
                    placeId: int.parse(id), reviewType: ReviewType.rental),
              );

          return buildTransitionPage(
            localKey: state.pageKey,
            child: const RentalPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.food.path,
        name: AppRoutes.food.name,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'];

          context.read<FoodBloc>().add(
                GetFoodEvent(int.parse(id!)),
              );
          context.read<ReviewListBloc>().add(
                GetReviewsEvent(
                    placeId: int.parse(id),
                    reviewType: ReviewType.foodestablishment),
              );

          return buildTransitionPage(
            localKey: state.pageKey,
            child: const FoodPage(),
          );
        },
      ),
    ],
  );
}

CustomTransitionPage buildTransitionPage({
  required LocalKey localKey,
  required Widget child,
}) {
  return CustomTransitionPage(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.linearToEaseOut).animate(animation),
        child: child,
      );
    },
    key: localKey,
    child: child,
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
