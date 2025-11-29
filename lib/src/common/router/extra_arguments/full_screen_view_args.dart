import 'package:flutter/material.dart';

class FullScreenViewArgs {
  const FullScreenViewArgs({
    required this.url,
    required this.urlSmall,
    required this.urlOrigin,
    required this.date,
    required this.onDelete,
  });
  factory FullScreenViewArgs.empty() =>
      FullScreenViewArgs(url: [], urlSmall: [], urlOrigin: '', date: DateTime.now(), onDelete: () {});
  final List<String> url;
  final List<String> urlSmall;
  final String urlOrigin;
  final DateTime date;
  final VoidCallback onDelete;
}
