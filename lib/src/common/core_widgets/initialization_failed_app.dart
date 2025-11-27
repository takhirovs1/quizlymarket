import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant/gen/assets.gen.dart';
import '../constant/gen/fonts.gen.dart';
import '../util/dimension.dart';

/// {@template initialization_failed_screen}
/// An enhanced screen that is shown when the initialization of the app fails.
/// Provides a user-friendly error display with retry functionality.
/// {@endtemplate}
class InitializationFailedApp extends StatefulWidget {
  /// {@macro initialization_failed_screen}
  const InitializationFailedApp({required this.error, required this.stackTrace, this.onRetryInitialization, super.key});

  final Object error;
  final StackTrace stackTrace;
  final Future<void> Function()? onRetryInitialization;

  @override
  State<InitializationFailedApp> createState() => _InitializationFailedAppState();
}

class _InitializationFailedAppState extends State<InitializationFailedApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: FontFamily.workSans,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: const Color(0xFF6938EF),
        selectionHandleColor: const Color(0xFF6938EF),
        selectionColor: const Color(0xFF6938EF).withValues(alpha: 0.3),
      ),
    ),
    home: InitializationFailedScreen(
      error: widget.error,
      stackTrace: widget.stackTrace,
      onRetryInitialization: widget.onRetryInitialization,
    ),
  );
}

class InitializationFailedScreen extends StatefulWidget {
  const InitializationFailedScreen({
    required this.error,
    required this.stackTrace,
    this.onRetryInitialization,
    super.key,
  });

  final Object error;
  final StackTrace stackTrace;
  final Future<void> Function()? onRetryInitialization;

  @override
  State<InitializationFailedScreen> createState() => _InitializationFailedScreen();
}

class _InitializationFailedScreen extends State<InitializationFailedScreen> {
  bool _showStackTrace = false;
  bool _inProgress = false;

  Future<void> _retryInitialization() async {
    if (_inProgress) return;

    _inProgress = true;
    setState(() {});

    await Future<void>.delayed(Duration.zero);

    await widget.onRetryInitialization?.call();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFf2f4f7),
    body: SafeArea(
      child: Padding(
        padding: Dimension.pAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: Dimension.rAll16,
                  child: Assets.images.placeholder.image(width: 150, height: 150, fit: BoxFit.cover),
                ),
              ],
            ),
            Dimension.hBox24,

            // Initialization failed text
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Initialization Failed',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Color(0xFFD92D20)),
                  textAlign: TextAlign.center,
                ),
                Dimension.wBox4,
                Icon(Icons.error_outline_rounded, size: 32, color: Color(0xFFD92D20)),
              ],
            ),
            Dimension.hBox24,

            // Error details
            Card(
              color: Colors.white,
              child: Padding(
                padding: Dimension.pAll16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Error Details:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    Text(
                      '${widget.error}',
                      style: const TextStyle(color: Color(0xFFD92D20), fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                    Dimension.hBox4,
                    Text(
                      'Occurred at: ${DateFormat('dd.MM.yyyy HH:mm:ss:SS').format(DateTime.now())}',
                      style: const TextStyle(fontSize: 10, color: Color(0xFF98A2B3)),
                    ),
                  ],
                ),
              ),
            ),
            Dimension.hBox12,

            // Retry button
            if (widget.onRetryInitialization != null)
              Container(
                height: 45,
                decoration: const BoxDecoration(color: Color(0xFFD83A88), borderRadius: Dimension.rAll10),
                child: CupertinoButton(
                  padding: Dimension.pZero,
                  onPressed: _inProgress ? null : _retryInitialization,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_inProgress) ...[
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: RepaintBoundary(
                            child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white),
                          ),
                        ),
                        Dimension.wBox4,
                      ],
                      Text(_inProgress ? 'Retrying...' : 'Retry', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            Dimension.hBox12,

            // Stack trace show toggle
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: Dimension.rAll10,
                border: Border.all(color: const Color.fromARGB(118, 102, 112, 133), width: 1.3),
              ),
              child: CupertinoButton(
                padding: Dimension.pZero,
                onPressed: () => setState(() => _showStackTrace = !_showStackTrace),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_showStackTrace ? Icons.expand_less : Icons.expand_more, color: const Color(0xFF1D2939)),
                    Dimension.wBox4,
                    Text(
                      _showStackTrace ? 'Hide Stack Trace' : 'Show Stack Trace',
                      style: const TextStyle(color: Color(0xFF1D2939), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),

            // Stack trace
            if (_showStackTrace) ...[
              Dimension.hBox12,
              Expanded(
                child: Card(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: Dimension.pAll16,
                    child: SelectableText(
                      '${widget.stackTrace}${widget.stackTrace}${widget.stackTrace}${widget.stackTrace}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
