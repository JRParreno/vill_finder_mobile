part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthUserLogout extends AuthEvent {}

class AuthGoogleSignInEvent extends AuthEvent {}

class AuthIsUserLoggedIn extends AuthEvent {}
