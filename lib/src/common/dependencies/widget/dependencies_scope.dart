import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    child: FutureBuilder<Dependencies>(
      future: Future<Dependencies>.delayed(Duration.zero, () async {
        final dependencies = await widget.initialization;

        await Future<void>.delayed(const Duration(milliseconds: 2000));

        return dependencies;
      }),
      builder: (context, snapshot) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        key: const ValueKey('dependencies_scope'),
        transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
        child: switch ((snapshot.data, snapshot.error, snapshot.stackTrace)) {
          (final Dependencies dependencies, null, null) => _InheritedDependencies(
            dependencies: dependencies,
            child: widget.child,
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
