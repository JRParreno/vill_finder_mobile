// coverage:ignore-file
part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState extends Equatable {
  const AppUserState();

  @override
  List<Object?> get props => [];
}

final class AppUserInitial extends AppUserState {}

final class GettingAppUser extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final UserEntity user;

  const AppUserLoggedIn(this.user);

  @override
  List<Object?> get props => [user];
}

final class AppUserFail extends AppUserState {
  final String message;

  const AppUserFail(this.message);

  @override
  List<Object?> get props => [message];
}
