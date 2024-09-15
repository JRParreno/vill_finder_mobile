// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:vill_finder/core/local_storage/shared_preferences_service.dart';

class SharedPreferencesNotifier extends ChangeNotifier {
  final SharedPreferencesService _prefsService;

  SharedPreferencesNotifier(this._prefsService);

  T getValue<T>(String key, T defaultValue) {
    return _prefsService.getValue<T>(key, defaultValue);
  }

  Future<void> setValue<T>(String key, T value) async {
    await _prefsService.setValue<T>(key, value);
    notifyListeners();
  }
}
