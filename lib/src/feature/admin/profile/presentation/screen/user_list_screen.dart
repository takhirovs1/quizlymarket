import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enum/bloc_status_enum.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../bloc/client/client_bloc.dart';
import '../state/user_list_state.dart';
import '../widget/user_tile_widget.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends UserListState {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: context.color.primary,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      elevation: 0,
      toolbarHeight: context.telegramWebApp.safeAreaInset.top + 56,
      surfaceTintColor: context.color.transparent,
      title: Column(
        children: [
          SizedBox(height: context.telegramWebApp.safeAreaInset.top.toDouble()),
          Center(
            child: Text(
              context.l10n.userList,
              style: context.textTheme.nunitoW600s24.copyWith(color: context.color.white),
            ),
          ),
        ],
      ),
    ),
    backgroundColor: context.color.background,
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: Dimension.pH16Top16,
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              decoration: const InputDecoration(hintText: 'Search by full name', prefixIcon: Icon(Icons.search)),
            ),
          ),
          Dimension.hBox16,
          Expanded(
            child: BlocBuilder<ClientBloc, ClientState>(
              builder: (context, state) => switch (state.status) {
                Status.loading => const Center(child: CircularProgressIndicator.adaptive()),
                Status.success =>
                  state.clients?.isEmpty ?? true
                      ? Center(
                          child: Text(
                            context.l10n.noUsersFound,
                            style: context.textTheme.nunitoW400s16.copyWith(color: context.color.onSurface),
                          ),
                        )
                      : ListView.separated(
                          padding: Dimension.pZero,
                          separatorBuilder: (context, index) => Dimension.divider,
                          itemBuilder: (context, index) => UserTile(
                            user: state.clients![index],
                            onTap: () {
                              context.telegramWebApp.hapticFeedback.impactOccurred(.light);
                            },
                          ),
                          itemCount: state.clients?.length ?? 0,
                        ),
                Status.error => Center(
                  child: Text(
                    state.error ?? context.l10n.unknownError,
                    style: context.textTheme.nunitoW400s16.copyWith(color: context.color.onSurface),
                  ),
                ),
                _ => const SizedBox.shrink(),
              },
            ),
          ),
        ],
      ),
    ),
  );
}
