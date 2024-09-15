// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:vill_finder/core/common/cubit/app_user_cubit.dart';
import 'package:vill_finder/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:vill_finder/features/auth/data/repository/auth_repository_impl.dart';
import 'package:vill_finder/features/auth/domain/repository/auth_repository.dart';
import 'package:vill_finder/features/auth/domain/usecase/index.dart';
import 'package:vill_finder/features/auth/presentation/bloc/auth_bloc.dart';

void initAuth(GetIt serviceLocator) {
  serviceLocator
    // Datasource
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseAuth: serviceLocator(),
        authService: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // Usecase
    ..registerFactory(
      () => UserGoogleSignin(serviceLocator()),
    )
    ..registerFactory(
      () => UserLogout(serviceLocator()),
    )
    ..registerFactory(
      () => VerifySigninToken(serviceLocator()),
    )
    ..registerFactory(
      () => CurrentUser(serviceLocator()),
    )

    // Bloc
    ..registerFactory(
      () => AuthBloc(
        currentUser: serviceLocator(),
        sharedPreferencesNotifier: serviceLocator(),
        appUserCubit: serviceLocator(),
        userGoogleSignin: serviceLocator(),
        userLogout: serviceLocator(),
        verifySigninToken: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AppUserCubit(),
    );
}
