import 'package:get_it/get_it.dart';
import 'package:vill_finder/features/review/data/datasources/review_remote_data_source.dart';
import 'package:vill_finder/features/review/data/repository/review_repository_impl.dart';
import 'package:vill_finder/features/review/domain/repository/review_repository.dart';
import 'package:vill_finder/features/review/domain/usecases/index.dart';
import 'package:vill_finder/features/review/presentation/bloc/cubit/review_star_cubit.dart';
import 'package:vill_finder/features/review/presentation/bloc/review_list_bloc.dart';

void reviewInit(GetIt serviceLocator) {
  serviceLocator
    ..registerFactory<ReviewRemoteDataSource>(
        () => ReviewRemoteDataSourceImpl())
    ..registerFactory<ReviewRepository>(
        () => ReviewRepositoryImpl(serviceLocator()))
    ..registerFactory(() => GetReviewList(serviceLocator()))
    ..registerFactory(() => AddReview(serviceLocator()))
    ..registerFactory(() => UpdateReview(serviceLocator()))
    ..registerFactory(
      () => ReviewListBloc(serviceLocator()),
    )
    ..registerFactory(() => ReviewStarCubit());
}
