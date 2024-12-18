// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:vill_finder/features/rental/data/data_sources/rental_remote_data_source.dart';
import 'package:vill_finder/features/rental/data/repository/rental_repository_impl.dart';
import 'package:vill_finder/features/rental/domain/repository/rental_repository.dart';
import 'package:vill_finder/features/rental/domain/usecases/index.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental/rental_bloc.dart';
import 'package:vill_finder/features/rental/presentation/blocs/rental_list_bloc/rental_list_bloc.dart';

void rentalInit(GetIt serviceLocator) {
  serviceLocator
    ..registerFactory<RentalRemoteDataSource>(
        () => RentalRemoteDataSourceImpl())
    ..registerFactory<RentalRepository>(
        () => RentalRepositoryImpl(serviceLocator()))
    ..registerFactory(() => GetRental(serviceLocator()))
    ..registerFactory(() => SetFavoriteRental(serviceLocator()))
    ..registerFactory(
      () => RentalBloc(
        updateReview: serviceLocator(),
        getRental: serviceLocator(),
        setFavoriteRental: serviceLocator(),
        addReview: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => RentalListBloc(
        serviceLocator(),
      ),
    );
}
