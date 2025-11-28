import 'package:flutter/material.dart';

import '../extension/context_extension.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    required this.leading,
    required this.title,
    this.textColor,
    this.onTap,
    this.isLogout = false,
    this.trailing,
    super.key,
  });
  final Widget leading;
  final Widget? trailing;
  final String title;
  final Color? textColor;
  final VoidCallback? onTap;
  final bool isLogout;
  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    leading: leading,
    title: Text(title, style: context.textTheme.nunitoW400s16.copyWith(color: textColor)),
    trailing: isLogout ? null : trailing ?? Icon(Icons.chevron_right, color: context.color.gray),
  );
}

class CustomTileChanger extends StatelessWidget {
  const CustomTileChanger({required this.title, required this.onTap, this.trailing, super.key});
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    title: Text(title, style: context.textTheme.nunitoW400s16),
    trailing: trailing,
  );
}
