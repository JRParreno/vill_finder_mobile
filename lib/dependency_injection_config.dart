import 'package:get_it/get_it.dart';
import 'package:vill_finder/core/di/index.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:vill_finder/core/firebase/auth_service.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // FirebaseAuth instance
  serviceLocator.registerLazySingleton<firebase_auth.FirebaseAuth>(
      () => firebase_auth.FirebaseAuth.instance);

  // FirebaseAuth instance
  serviceLocator.registerLazySingleton(() => AuthService(serviceLocator()));

  // app permission
  initPersmissionService(serviceLocator);
  // Shared preferences
  await setupSharedPreferencesDependencies(serviceLocator);
  // set authentication feature
  initAuth(serviceLocator);
  // set Home feature
  homeBusinessInit(serviceLocator);
  // set Map feature
  mapBusinessInit(serviceLocator);
}
