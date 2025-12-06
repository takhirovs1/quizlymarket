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
  AuthBloc? _authBloc;
  StreamSubscription<AuthState>? _authStateSubscription;
  late Future<Dependencies> _dependenciesFuture;
  bool _signUpRequested = false;

  @override
  void initState() {
    super.initState();
    _dependenciesFuture = _initializeDependencies();
  }

  @override
  void didUpdateWidget(covariant DependenciesScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialization != oldWidget.initialization) {
      _resetAuthFlow();
      _dependenciesFuture = _initializeDependencies();
    }
  }

  Future<Dependencies> _initializeDependencies() async {
    final dependencies = await widget.initialization;
    await _ensureAuthenticated(dependencies);
    return dependencies;
  }

  Future<void> _ensureAuthenticated(Dependencies dependencies) async {
    _authBloc ??= AuthBloc(repository: dependencies.repository.authRepository);
    _signUpRequested = false;
    final bloc = _authBloc!;
    final completer = Completer<void>();

    if (_authStateSubscription != null) {
      await _authStateSubscription!.cancel();
      _authStateSubscription = null;
    }

    final telegramUser = TelegramWebApp.instance.initDataUnsafe?.user;
    final telegramId = telegramUser?.id;
    final telegramID = telegramId?.toString();

    _authStateSubscription = bloc.stream.listen((state) {
      if (state.isUserExist == false && !_signUpRequested) {
        _signUpRequested = true;
        _requestSignUp(bloc);
      }

      if (state.status == Status.success && state.user != null) {
        if (!completer.isCompleted) completer.complete();
      } else if (state.status == Status.error) {
        _completeWithError(completer, state.error ?? 'Unknown error');
      }
    });

    if (telegramID == null || telegramID.isEmpty) {
      _completeWithError(completer, 'Missing Telegram user identifier');
    } else {
      bloc.add(LoginEvent(telegramID: telegramID));
    }

    try {
      await completer.future;
    } finally {
      if (_authStateSubscription != null) {
        await _authStateSubscription!.cancel();
        _authStateSubscription = null;
      }
    }
  }

  void _requestSignUp(AuthBloc bloc) {
    final telegramUser = TelegramWebApp.instance.initDataUnsafe?.user;
    final telegramId = telegramUser?.id;
    bloc.add(
      SignUpEvent(
        telegramID: telegramId == null ? '' : telegramId.toString(),
        name: '${telegramUser?.firstName ?? ''} ${telegramUser?.lastName ?? ''}'.trim(),
        telegramUsername: telegramUser?.username ?? '',
      ),
    );
  }

  void _completeWithError(Completer<void> completer, String message) {
    if (!completer.isCompleted) completer.completeError(StateError(message), StackTrace.current);
  }

  void _resetAuthFlow() {
    _signUpRequested = false;
    unawaited(_authStateSubscription?.cancel());
    _authStateSubscription = null;
    _authBloc?.close();
    _authBloc = null;
  }

  @override
  void dispose() {
    _resetAuthFlow();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    child: FutureBuilder<Dependencies>(
      future: _dependenciesFuture,
      builder: (context, snapshot) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        key: const ValueKey('dependencies_scope'),
        transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
        child: switch ((snapshot.data, snapshot.error, snapshot.stackTrace)) {
          (final Dependencies dependencies, null, null) => BlocProvider.value(
            value: _authBloc!,
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
