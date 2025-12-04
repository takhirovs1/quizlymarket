import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/logger.dart';
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
    _setupTelegramBackButton();
  }

  @override
  void dispose() {
    _teardownTelegramBackButton();
    super.dispose();
  }

  void _setupTelegramBackButton() {
    if (!kIsWeb) return;

    try {
      if (!context.telegramWebApp.isSupported) return;

      context.telegramWebApp.backButton
        ..onClick(_handleTelegramBackButtonPressed)
        ..show();
    } on Object catch (error, stackTrace) {
      warning(error, stackTrace, 'Failed to show Telegram back button');
    }
  }

  void _teardownTelegramBackButton() {
    if (!kIsWeb) return;

    try {
      if (!context.telegramWebApp.isSupported) return;

      context.telegramWebApp.backButton
        ..offClick(_handleTelegramBackButtonPressed)
        ..hide();
    } on Object catch (error, stackTrace) {
      warning(error, stackTrace, 'Failed to hide Telegram back button');
    }
  }

  void _handleTelegramBackButtonPressed() {
    context.telegramWebApp.hapticFeedback.impactOccurred(.light);
    if (!mounted) return;

    context.pop();
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
