// coverage:ignore-file
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/user_entity.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(GettingAppUser());

  void updateUser(UserEntity? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }

  void logout() {
    emit(AppUserInitial());
  }

  void failSetUser(String message) {
    emit(AppUserFail(message));
  }

  void userLoggedIn() {
    emit(GettingAppUser());
  }
}
