import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../common/enum/bloc_status_enum.dart';
import '../../../common/util/error_handler.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository repository, AuthState? initialState})
    : _repository = repository,
      super(initialState ?? const AuthState()) {
    on<AuthEvent>(
      (event, emit) => switch (event) {
        final LoginEvent e => _onLoginEvent(e, emit),
        final SignUpEvent e => _onSignUpEvent(e, emit),
      },
    );
  }
  final AuthRepository _repository;

  void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) => handle(
    () async {
      emit(state.copyWith(status: Status.loading));
      final user = await _repository.login(telegramID: event.telegramID);
      emit(state.copyWith(status: Status.success, user: () => user));
    },
    onError: (error, stackTrace) {
      emit(state.copyWith(status: Status.error, error: () => error.toString()));
    },
  );

  void _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) => handle(
    () async {
      emit(state.copyWith(status: Status.loading));
      final user = await _repository.signUp(
        telegramID: event.telegramID,
        name: event.name,
        telegramUsername: event.telegramUsername,
      );
      emit(state.copyWith(status: Status.success, user: () => user));
    },
    onError: (error, stackTrace) {
      emit(state.copyWith(status: Status.error, error: () => error.toString()));
    },
  );
}
