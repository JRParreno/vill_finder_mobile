import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vill_finder/core/common/cubit/app_user_cubit.dart';
import 'package:vill_finder/core/config/shared_prefences_keys.dart';
import 'package:vill_finder/core/notifier/shared_preferences_notifier.dart';

mixin AppCheck {
  bool isUserLogged(BuildContext context) {
    final isLogged = context.read<AppUserCubit>().state is AppUserLoggedIn;
    final sharedPreferencesNotifier =
        GetIt.instance<SharedPreferencesNotifier>();
    final isSharedLogged = sharedPreferencesNotifier.getValue(
        SharedPreferencesKeys.isLoggedIn, false);

    return isLogged && isSharedLogged;
  }
}
