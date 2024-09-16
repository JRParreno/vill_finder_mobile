// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:vill_finder/features/map/data/data_source/business_map_remote_data_source.dart';
import 'package:vill_finder/features/map/data/repository/business_map_repository_impl.dart';
import 'package:vill_finder/features/map/domain/repository/business_map_repository.dart';
import 'package:vill_finder/features/map/domain/usecase/get_business_map_list.dart';
import 'package:vill_finder/features/map/presentation/blocs/map_business/map_business_bloc.dart';

void mapBusinessInit(GetIt serviceLocator) {
  serviceLocator
    // Datasource
    ..registerFactory<BusinessMapRemoteDataSource>(
      () => BusinessMapRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<BusinessMapRepository>(
      () => BusinessMapRepositoryImpl(serviceLocator()),
    )
    // Usecase
    ..registerFactory(
      () => GetBusinessMapList(serviceLocator()),
    )
    ..registerFactory(
      () => MapBusinessBloc(serviceLocator()),
    );
}
