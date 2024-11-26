part of 'login_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

final class AuthSuccess extends AuthState {
  final User? user;

  AuthSuccess({required this.user});
}

sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupError extends SignupState {
  final String message;

  SignupError({required this.message});
}

final class SignupSuccess extends SignupState {
  final String? response;

  SignupSuccess({required this.response});
}
