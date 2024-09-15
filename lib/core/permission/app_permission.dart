// coverage:ignore-file
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  Future<bool> locationPermission();
}

class PermissionServiceImpl implements PermissionService {
  @override
  Future<bool> locationPermission() async {
    final permission = await Permission.location.request();
    if (permission.isDenied || permission.isPermanentlyDenied) {
      return false;
    }
    return true;
  }
}
