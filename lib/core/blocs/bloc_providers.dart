import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vill_finder/core/common/cubit/app_user_cubit.dart';
import 'package:vill_finder/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vill_finder/features/favorite/presentation/bloc/rental_favorite_bloc.dart';
import 'package:vill_finder/features/food/presentation/blocs/food/food_bloc.dart';
import 'package:vill_finder/features/food/presentation/blocs/food_list_bloc/food_list_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/cubit/cubit/category_cubit.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_food/home_food_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_rental/home_rental_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/search/search_bloc.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';
import 'package:vill_finder/features/navigation/presentation/cubit/navigator_index_cubit.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental/rental_bloc.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental_list_bloc/rental_list_bloc.dart';
import 'package:vill_finder/features/review/presentation/bloc/cubit/review_star_cubit.dart';
import 'package:vill_finder/features/review/presentation/bloc/review_list_bloc.dart';

class BlocProviders {
  static blocs(GetIt serviceLocator) {
    return [
      BlocProvider(
        create: (context) => NavigatorIndexCubit(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<HomeRentalListBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<HomeFoodListBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<CategoryCubit>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<MapBusinessBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<SearchBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<FoodListBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<RentalListBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<RentalBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<FoodBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<ReviewListBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<ReviewStarCubit>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<RentalFavoriteBloc>(),
      ),
    ];
  }
}
