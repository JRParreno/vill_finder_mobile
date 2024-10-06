// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:vill_finder/features/food/presentation/blocs/food_bloc/food_bloc.dart';

void foodInit(GetIt serviceLocator) {
  serviceLocator.registerFactory(
    () => FoodBloc(
      serviceLocator(),
    ),
  );
}
