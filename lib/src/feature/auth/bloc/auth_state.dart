part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({this.status = Status.initial, this.user, this.error, this.isUserExist});

  final Status status;
  final UserModel? user;
  final String? error;
  final bool? isUserExist;

  AuthState copyWith({
    Status? status,
    ValueGetter<UserModel?>? user,
    ValueGetter<String?>? error,
    ValueGetter<bool?>? isUserExist,
  }) => AuthState(
    status: status ?? this.status,
    user: user != null ? user() : this.user,
    error: error != null ? error() : this.error,
    isUserExist: isUserExist != null ? isUserExist() : this.isUserExist,
  );

  @override
  List<Object?> get props => [status, user, error, isUserExist];
}
