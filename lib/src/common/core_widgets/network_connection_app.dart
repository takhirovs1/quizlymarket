import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../constant/gen/assets.gen.dart';
import '../extension/context_extension.dart';
import '../util/dimension.dart';

/// {@template network_connection_app}
/// NetworkConnectionApp widget.
/// {@endtemplate}
class NetworkConnectionApp extends StatefulWidget {
  /// {@macro network_connection_app}
  const NetworkConnectionApp({required this.child, super.key});

  final Widget child;

  @override
  State<NetworkConnectionApp> createState() => _NetworkConnectionAppState();
}

/// State for widget NetworkConnectionApp.
class _NetworkConnectionAppState extends State<NetworkConnectionApp> {
  late final Connectivity connectivity;

  @override
  void initState() {
    super.initState();
    connectivity = context.dependencies.connectivity;
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
    stream: connectivity.onConnectivityChanged,
    builder: (context, snapshot) => switch (snapshot.data) {
      final List<ConnectivityResult> a
          when a.any((e) => e == ConnectivityResult.mobile || e == ConnectivityResult.wifi) =>
        widget.child,
      null => Scaffold(backgroundColor: context.color.white),
      _ => Scaffold(
        backgroundColor: context.color.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: Dimension.rAll32,
                  child: Assets.images.placeholder.image(width: 150, height: 150),
                ),
                Dimension.hBox12,

                /// No internet text
                Text(
                  context.l10n.noInternetConnection,
                  style: context.textTheme.workSansW500s24,
                  textAlign: TextAlign.center,
                ),

                /// No internet description text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    context.l10n.noInternetConnectionDescription,
                    style: context.textTheme.workSansW400s16,
                    textAlign: TextAlign.center,
                  ),
                ),
                Dimension.hBox20,

                GestureDetector(
                  onTap: connectivity.checkConnectivity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh_outlined, color: context.color.white),
                      Dimension.wBox4,
                      Text(
                        context.l10n.refresh,
                        style: context.textTheme.workSansW500s16.copyWith(color: context.color.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    },
  );
}
