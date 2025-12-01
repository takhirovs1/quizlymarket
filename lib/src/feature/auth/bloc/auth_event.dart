part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class LoginEvent extends AuthEvent {
  const LoginEvent({required this.telegramID});

  final String telegramID;

  @override
  List<Object> get props => [telegramID];
}
