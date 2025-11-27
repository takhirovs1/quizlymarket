import 'package:flutter/material.dart' show BuildContext, ScaffoldMessenger, SnackBar, Text, Colors;

sealed class ErrorUtil {
  const ErrorUtil._();

  static Future<void> logError(Object exception, StackTrace stackTrace, {String? hint}) async {
    return;
  }

  static Never throwWithStackTrace(Object error, StackTrace stackTrace) => Error.throwWithStackTrace(error, stackTrace);

  static void showSnackBar(BuildContext context, Object message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$message'), backgroundColor: Colors.red));
}
