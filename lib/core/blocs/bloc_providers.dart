import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vill_finder/core/common/cubit/app_user_cubit.dart';
import 'package:vill_finder/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_food/home_food_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_rental/home_rental_bloc.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';

class BlocProviders {
  static blocs(GetIt serviceLocator) {
    return [
      BlocProvider(
        create: (context) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<HomeRentalBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<HomeFoodBloc>(),
      ),
      BlocProvider(
        create: (context) => serviceLocator<MapBusinessBloc>(),
      ),
    ];
  }
}
