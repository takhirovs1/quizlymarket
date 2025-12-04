import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../../../feature/auth/bloc/auth_bloc.dart';
import '../../enum/bloc_status_enum.dart';
import '../../extension/context_extension.dart';
import '../model/dependencies.dart';

class DependenciesScope extends StatefulWidget {
  const DependenciesScope({
    required this.initialization,
    required this.child,
    this.splashScreen,
    this.errorBuilder,
    super.key,
  });

  static Dependencies of(BuildContext context) => context.inhOf<_InheritedDependencies>(listen: false).dependencies;

  final Future<Dependencies> initialization;
  final Widget? splashScreen;
  final Widget Function(Object error, StackTrace? stackTrace)? errorBuilder;
  final Widget child;

  @override
  State<DependenciesScope> createState() => _DependenciesScopeState();
}

class _DependenciesScopeState extends State<DependenciesScope> {
  AuthBloc? authBloc;

  late final Completer<Dependencies> _dependenciesCompleter = Completer<Dependencies>();

  StreamSubscription<AuthState>? _authStateSubscription;

  Future<Dependencies> _initializeDependencies() async {
    final dependencies = await widget.initialization;
    await Future<void>.delayed(const Duration(milliseconds: 2000));
    if (authBloc == null) {
      authBloc = AuthBloc(repository: dependencies.repository.authRepository);
      final telegramID = TelegramWebApp.instance.initDataUnsafe?.user?.id.toString();
      if (telegramID != null) authBloc?.add(LoginEvent(telegramID: telegramID));
      _authStateSubscription = authBloc?.stream.asBroadcastStream().listen((state) {
        if (state.isUserExist == false) {
          final telegramUser = TelegramWebApp.instance.initDataUnsafe?.user;
          authBloc?.add(
            SignUpEvent(
              telegramID: telegramUser?.id.toString() ?? '',
              name: '${telegramUser?.firstName} ${telegramUser?.lastName ?? ''}'.trim(),
              telegramUsername: telegramUser?.username ?? '',
            ),
          );
        }
        if (state.status == Status.success && state.user != null) {
          _dependenciesCompleter.complete(dependencies);
          _authStateSubscription?.cancel();
        }
        if (state.status == Status.error) {
          _dependenciesCompleter.completeError(state.error ?? 'Unknown error');
          _authStateSubscription?.cancel();
        }
      });
    } else {
      _dependenciesCompleter.complete(dependencies);
    }

    return _dependenciesCompleter.future;
  }

  @override
  void dispose() {
    authBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    child: FutureBuilder<Dependencies>(
      future: _initializeDependencies(),
      builder: (context, snapshot) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        key: const ValueKey('dependencies_scope'),
        transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
        child: switch ((snapshot.data, snapshot.error, snapshot.stackTrace)) {
          (final Dependencies dependencies, null, null) => BlocProvider.value(
            value: authBloc!,
            child: _InheritedDependencies(dependencies: dependencies, child: widget.child),
          ),
          (_, final Object error, final StackTrace? stackTrace) =>
            widget.errorBuilder?.call(error, stackTrace) ?? ErrorWidget(error),
          _ => widget.splashScreen ?? const SizedBox.shrink(),
        },
      ),
    ),
  );
}

class _InheritedDependencies extends InheritedWidget {
  const _InheritedDependencies({required this.dependencies, required super.child});

  final Dependencies dependencies;

  @override
  bool updateShouldNotify(covariant _InheritedDependencies oldWidget) => false;
}
