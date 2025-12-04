import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enum/bloc_status_enum.dart';
import '../../../../../common/extension/context_extension.dart';
import '../bloc/client/client_bloc.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late final TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final searchQuery = value.trim();
      context.read<ClientBloc>().add(searchQuery.isEmpty ? const GetClientsEvent() : GetClientsEvent(searchQuery: searchQuery));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.color.background,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(hintText: 'Search by full name', prefixIcon: Icon(Icons.search)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ClientBloc, ClientState>(
                builder: (context, state) {
                  final clients = state.clients ?? const [];
                  if (state.status == Status.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (clients.isEmpty) {
                    return const Center(child: Text('No users found'));
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) => ListTile(
                      title: Text(clients[index].name),
                      subtitle: Text(clients[index].telegramUsername ?? ''),
                    ),
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemCount: clients.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
