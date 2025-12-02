part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({this.status = Status.initial, this.user, this.error});

  final Status status;
  final UserModel? user;
  final String? error;

  AuthState copyWith({Status? status, ValueGetter<UserModel?>? user, ValueGetter<String?>? error}) => AuthState(
    status: status ?? this.status,
    user: user != null ? user() : this.user,
    error: error != null ? error() : this.error,
  );

  @override
  List<Object?> get props => [status, user, error];
}
