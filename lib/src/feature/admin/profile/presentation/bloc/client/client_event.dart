part of 'client_bloc.dart';

class ClientEvent {
  const ClientEvent();
}

class GetClientsEvent extends ClientEvent {
  const GetClientsEvent({this.searchQuery = ''});

  final String searchQuery;
}

class UpdateClientRoleEvent extends ClientEvent {
  const UpdateClientRoleEvent({required this.userID, required this.role});
  final String userID;
  final UserRole role;
}
