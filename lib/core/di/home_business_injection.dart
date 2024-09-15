// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:vill_finder/features/home/data/data_sources/business_remote_data_source.dart';
import 'package:vill_finder/features/home/data/repository/business_repository_impl.dart';
import 'package:vill_finder/features/home/domain/repository/business_repository.dart';
import 'package:vill_finder/features/home/domain/usecase/index.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_business/home_business_bloc.dart';
import 'package:vill_finder/features/home/presentation/blocs/home_business_category/home_business_category_bloc.dart';

void homeBusinessInit(GetIt serviceLocator) {
  serviceLocator
    // Datasource
    ..registerFactory<BusinessRemoteDataSource>(
      () => BusinessRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<BusinessRepository>(
      () => BusinessRepositoryImpl(serviceLocator()),
    )
    // Usecase
    ..registerFactory(
      () => GetHomeBusinessCategoryList(serviceLocator()),
    )
    ..registerFactory(
      () => GetHomeBusinessList(serviceLocator()),
    )
    // Bloc
    ..registerFactory(
      () => HomeBusinessBloc(serviceLocator()),
    )
    ..registerFactory(
      () => HomeBusinessCategoryBloc(serviceLocator()),
    );
}
