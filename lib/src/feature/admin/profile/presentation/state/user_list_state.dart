import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../bloc/client/client_bloc.dart';
import '../screen/user_list_screen.dart';

abstract class UserListState extends State<UserListScreen> {
  late final ClientBloc clientBloc;
  late final TextEditingController searchController;

  @override
  void initState() {
    clientBloc = ClientBloc(repository: context.dependencies.repository.clientRepository);
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged(String value) {
    final searchQuery = value.trim();
    if (searchQuery.isEmpty) {
      clientBloc.add(const GetClientsEvent());
      return;
    }
    if (searchQuery.length <= 3) {
      return;
    }
    clientBloc.add(GetClientsEvent(searchQuery: searchQuery));
  }
}
