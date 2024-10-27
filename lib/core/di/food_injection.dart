// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:vill_finder/features/food/data/data_sources/food_remote_data_source.dart';
import 'package:vill_finder/features/food/data/repository/food_repository_impl.dart';
import 'package:vill_finder/features/food/domain/repository/food_repository.dart';
import 'package:vill_finder/features/food/domain/usecases/get_food_establishment.dart';
import 'package:vill_finder/features/food/presentation/blocs/food/food_bloc.dart';
import 'package:vill_finder/features/food/presentation/blocs/food_list_bloc/food_list_bloc.dart';

void foodInit(GetIt serviceLocator) {
  serviceLocator
    ..registerFactory<FoodRemoteDataSource>(() => FoodRemoteDataSourceImpl())
    ..registerFactory<FoodRepository>(
        () => FoodRepositoryImpl(serviceLocator()))
    ..registerFactory<GetFoodEstablishment>(
        () => GetFoodEstablishment(serviceLocator()))
    ..registerFactory(
      () => FoodBloc(
        addReview: serviceLocator(),
        getFoodEstablishment: serviceLocator(),
        updateReview: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => FoodListBloc(
        serviceLocator(),
      ),
    );
}
