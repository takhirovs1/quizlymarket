part of 'client_bloc.dart';

class ClientState extends Equatable {
  const ClientState({this.status = Status.initial, this.clients, this.error, this.client});

  final Status status;
  final List<ClientModel>? clients;
  final String? error;
  final ClientModel? client;

  ClientState copyWith({Status? status, List<ClientModel>? clients, String? error, ClientModel? client}) => ClientState(
    status: status ?? this.status,
    clients: clients ?? this.clients,
    error: error ?? this.error,
    client: client ?? this.client,
  );

  @override
  List<Object?> get props => [status, clients, error, client];
}
