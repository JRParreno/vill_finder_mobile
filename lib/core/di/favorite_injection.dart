// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:vill_finder/features/favorite/data/data_sources/favorite_remote_data_source.dart';
import 'package:vill_finder/features/favorite/data/repository/favorite_repository_impl.dart';
import 'package:vill_finder/features/favorite/domain/repository/favorite_repository.dart';
import 'package:vill_finder/features/favorite/domain/usecases/get_favorites.dart';
import 'package:vill_finder/features/favorite/presentation/bloc/rental_favorite_bloc.dart';

void favoriteInit(GetIt serviceLocator) {
  serviceLocator
    ..registerFactory<FavoriteRemoteDataSource>(
        () => FavoriteRemoteDataSourceImpl())
    ..registerFactory<FavoriteRepository>(
        () => FavoriteRepositoryImpl(serviceLocator()))
    ..registerFactory<GetFavorites>(() => GetFavorites(serviceLocator()))
    ..registerFactory(
      () => RentalFavoriteBloc(
        serviceLocator(),
      ),
    );
}
