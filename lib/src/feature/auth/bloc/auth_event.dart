part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class LoginEvent extends AuthEvent {
  const LoginEvent({required this.telegramID});

  final String telegramID;
}

final class SignUpEvent extends AuthEvent {
  const SignUpEvent({required this.telegramID, required this.name, required this.telegramUsername});

  final String telegramID;
  final String name;
  final String telegramUsername;
}
