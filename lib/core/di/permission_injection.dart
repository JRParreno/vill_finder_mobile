// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:vill_finder/core/permission/app_permission.dart';

void initPersmissionService(GetIt serviceLocator) {
  serviceLocator
      .registerLazySingleton<PermissionService>(() => PermissionServiceImpl());
}
