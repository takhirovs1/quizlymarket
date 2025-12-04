import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enum/bloc_status_enum.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/extension/int_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../data/model/user_list_model.dart';
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
      context.read<ClientBloc>().add(
        searchQuery.isEmpty ? const GetClientsEvent() : GetClientsEvent(searchQuery: searchQuery),
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.color.background,
    body: SafeArea(
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
                  return const Center(child: CircularProgressIndicator.adaptive());
                }
                if (clients.isEmpty) {
                  return Center(
                    child: Text('No users found', style: TextStyle(color: context.color.onSurface)),
                  );
                }
                return ListView.separated(
                  padding: Dimension.pZero,
                  separatorBuilder: (context, index) => Dimension.divider,
                  itemBuilder: (context, index) => UserTile(user: clients[index], onTap: () {}),
                  itemCount: clients.length,
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class UserTile extends StatelessWidget {
  const UserTile({required this.user, required this.onTap, super.key});
  final ClientModel user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: Dimension.pH16V4,
      child: Row(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: Padding(
                padding: Dimension.pAll4,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: context.color.primary, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      user.name.characters.first.toUpperCase(),
                      style: context.textTheme.nunitoW600s16.copyWith(color: context.color.onPrimary),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Column(
              spacing: 4,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(user.name, style: context.textTheme.sfProW500s16.copyWith(color: context.color.black)),
                    Text(
                      user.balance.toInt().toUZSString(),
                      style: context.textTheme.sfProW500s16.copyWith(
                        color: context.color.success,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    if (user.telegramUsername != null && user.telegramUsername!.isNotEmpty) ...[
                      Text(
                        '@${user.telegramUsername}',
                        style: context.textTheme.sfProW400s12.copyWith(color: context.color.gray),
                      ),
                    ],
                    Text(
                      'ID: ${user.telegramID}',
                      style: context.textTheme.sfProW500s12.copyWith(color: context.color.gray),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
