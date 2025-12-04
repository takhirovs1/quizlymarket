import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/client/client_bloc.dart';
import '../screen/user_list_screen.dart';

abstract class UserListState extends State<UserListScreen> {
  late final ClientBloc clientBloc;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    clientBloc = context.read<ClientBloc>();
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
    clientBloc.add(GetClientsEvent(searchQuery: searchQuery));
  }
}
