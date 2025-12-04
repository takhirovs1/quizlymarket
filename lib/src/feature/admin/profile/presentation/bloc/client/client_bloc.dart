import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/enum/bloc_status_enum.dart';
import '../../../../../../common/enum/user_role_enum.dart';
import '../../../../../../common/util/error_handler.dart';
import '../../../../../../common/util/logger.dart';
import '../../../data/model/user_list_model.dart';
import '../../../data/repository/client_repository.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc({required ClientRepository repository, ClientState? initialState})
    : _repository = repository,
      super(initialState ?? const ClientState()) {
    on<ClientEvent>(
      (event, emit) => switch (event) {
        final GetClientsEvent e => _onGetClientsEvent(e, emit),
        final UpdateClientRoleEvent e => _onUpdateClientRoleEvent(e, emit),
        _ => emit(state.copyWith(status: Status.error, error: 'Unknown event')),
      },
      transformer: restartable(),
    );
  }
  final ClientRepository _repository;

  void _onGetClientsEvent(GetClientsEvent event, Emitter<ClientState> emit) => handle(
    () async {
      emit(state.copyWith(status: Status.loading));
      final clients = await _repository.getClients(searchQuery: event.searchQuery);
      info('clients: $clients');
      emit(state.copyWith(status: Status.success, clients: clients));
    },
    onError: (error, stackTrace) {
      emit(state.copyWith(status: Status.error, error: error.toString()));
    },
  );

  void _onUpdateClientRoleEvent(UpdateClientRoleEvent event, Emitter<ClientState> emit) => handle(
    () async {
      emit(state.copyWith(status: Status.loading));
      final client = await _repository.updateClientRole(event.userID, event.role);
      emit(state.copyWith(status: Status.success, client: client));
    },
    onError: (error, stackTrace) {
      emit(state.copyWith(status: Status.error, error: error.toString()));
    },
  );
}
