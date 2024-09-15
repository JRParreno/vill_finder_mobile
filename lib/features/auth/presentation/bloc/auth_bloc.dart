import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/common/cubit/app_user_cubit.dart';
import 'package:vill_finder/core/common/entities/user_entity.dart';
import 'package:vill_finder/core/config/shared_prefences_keys.dart';
import 'package:vill_finder/core/notifier/shared_preferences_notifier.dart';
import 'package:vill_finder/core/usecase/usecase.dart';

import '../../domain/usecase/index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferencesNotifier _sharedPreferencesNotifier;
  final UserGoogleSignin _userGoogleSignin;
  final AppUserCubit _appUserCubit;
  final UserLogout _userLogout;
  final VerifySigninToken _verifySigninToken;
  final CurrentUser _currentUser;

  AuthBloc({
    required SharedPreferencesNotifier sharedPreferencesNotifier,
    required AppUserCubit appUserCubit,
    required UserGoogleSignin userGoogleSignin,
    required UserLogout userLogout,
    required VerifySigninToken verifySigninToken,
    required CurrentUser currentUser,
  })  : _sharedPreferencesNotifier = sharedPreferencesNotifier,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _userGoogleSignin = userGoogleSignin,
        _userLogout = userLogout,
        _verifySigninToken = verifySigninToken,
        super(AuthInitial()) {
    on<AuthGoogleSignInEvent>(onAuthGoogleSignInEvent);
    on<AuthUserLogout>(onAuthUserLogout);
    on<AuthIsUserLoggedIn>(onAuthIsUserLoggedIn);
  }

  Future<void> onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _currentUser(NoParams());

    response.fold(
      (l) => handleFailSetUserCubit(message: l.message, emit: emit),
      (r) => handleSetUserCubit(emit: emit, user: r),
    );
  }

  Future<void> onAuthUserLogout(
      AuthUserLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogout(NoParams());

    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) {
        _sharedPreferencesNotifier.setValue(
            SharedPreferencesKeys.isLoggedIn, false);
        _appUserCubit.logout();

        emit(AuthInitial());
      },
    );
  }

  Future<void> onAuthGoogleSignInEvent(
      AuthGoogleSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final response = await _userGoogleSignin(NoParams());

      await response.fold(
        (l) async {
          _appUserCubit.failSetUser(l.message);
          emit(AuthFailure(l.message));
        },
        (r) async {
          final verifyToken = await _verifySigninToken(r);

          await verifyToken.fold(
            (left) async {
              _appUserCubit.failSetUser(left.message);
              emit(AuthFailure(left.message));
            },
            (r) async {
              // this will save token in localstorage
              handleSetInfo(
                  accessToken: r.accessToken, refreshToken: r.refreshToken);
              // handle set user cubit and emit
              handleSetUserCubit(emit: emit, user: r.user);
            },
          );
        },
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void handleSetInfo(
      {required String accessToken, required String refreshToken}) {
    _sharedPreferencesNotifier.setValue(SharedPreferencesKeys.isLoggedIn, true);
    _sharedPreferencesNotifier.setValue(
        SharedPreferencesKeys.accessToken, accessToken);
    _sharedPreferencesNotifier.setValue(
        SharedPreferencesKeys.refreshToken, refreshToken);
  }

  void handleSetUserCubit(
      {required UserEntity user, required Emitter<AuthState> emit}) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void handleFailSetUserCubit(
      {required String message, required Emitter<AuthState> emit}) {
    _appUserCubit.failSetUser(message);
    emit(AuthFailure(message));
  }
}
