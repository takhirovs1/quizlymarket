import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/model/language_option.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_bottom_sheet.dart';
import '../../../../../common/widget/custom_tile.dart';
import '../../../../../feature/auth/bloc/auth_bloc.dart';
import '../../../../../feature/auth/model/user_model.dart';
import '../../data/models/telegram_user_model.dart';
import '../screen/profile_screen.dart';

abstract class ProfileState extends State<ProfileScreen> {
  late final ProfileUserData profileData;
  late String currentLocale;

  @override
  void initState() {
    super.initState();
    profileData = ProfileUserData.fromUserModel(_resolveUserModel());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentLocale = Localizations.localeOf(context).languageCode;
  }

  UserModel _resolveUserModel() {
    try {
      final authBloc = context.read<AuthBloc>();
      return authBloc.state.user ?? MockUsers.activeUser;
    } on Object catch (_) {
      return MockUsers.activeUser;
    }
  }

  String formatVersion() {
    final raw = context.appMetadata.appVersion;
    final parts = raw.split('+');
    if (parts.length == 2) return '${parts[0]}(+${parts[1]})';
    return raw;
  }

  Future<void> logOut() async => await showCupertinoDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => CupertinoAlertDialog(
      title: Text(context.l10n.signOut),
      content: Padding(padding: Dimension.pTop8, child: Text(context.l10n.logoutConfirmMessage)),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            context.l10n.logoutCancel,
            style: context.textTheme.nunitoW600s16.copyWith(color: context.color.primary),
          ),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            context.localSource.clearAll().then((_) => context.telegramWebApp.close());
            Navigator.of(context).pop();
          },
          child: Text(
            context.l10n.logoutConfirm,
            style: context.textTheme.nunitoW400s16.copyWith(color: context.color.error),
          ),
        ),
      ],
    ),
  );

  Future<void> onTapLanguageChange() async {
    final languages = <LanguageOption>[
      LanguageOption(code: 'en', label: context.l10n.english),
      LanguageOption(code: 'ru', label: context.l10n.russian),
      LanguageOption(code: 'uz', label: context.l10n.uzbek),
    ];

    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: context.color.transparent,
      builder: (ctx) => CustomBottomSheet(
        maxChildSize: .35,
        initialChildSize: .34,
        children: [
          Text(context.l10n.language, style: context.textTheme.nunitoW600s24),
          Dimension.hBox12,
          Material(
            color: context.color.white,
            shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll10),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (final (index, option) in languages.indexed) ...[
                  CustomTileChanger(
                    trailing: currentLocale == option.code ? const Icon(Icons.check) : null,
                    title: option.label,
                    onTap: () => _changeLocale(option.code),
                  ),
                  if (index != languages.length - 1) Dimension.divider,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _changeLocale(String code) {
    if (currentLocale == code) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => currentLocale = code);
    context.setLocale(Locale(code));
    Navigator.of(context).pop();
  }
}
