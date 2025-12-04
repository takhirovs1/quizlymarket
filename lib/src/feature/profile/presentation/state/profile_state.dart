import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../../../../common/constant/urls.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/model/language_option.dart';
import '../../../../common/router/route.dart';
import '../../../../common/util/dimension.dart';
import '../../../../common/widget/custom_bottom_sheet.dart';
import '../../../../common/widget/custom_tile.dart';
import '../../data/models/telegram_user_model.dart';
import '../screen/profile_screen.dart';

abstract class ProfileState extends State<ProfileScreen> {
  late final ProfileUserData profileData;
  late final bool isTelegramUser;
  late String currentLocale;
String? profilePhotoUrl;
  String? avatarUrl;
  bool isLoading = true;
  String? error;
  // String get _profilePhotoUrl => _profilePhotoUrl ?? profileData.photoUrl ?? '';

  @override
  void initState() {
    super.initState();
    final telegramUser = _resolveTelegramUser();
    isTelegramUser = telegramUser != null;
    profileData = telegramUser != null
        ? ProfileUserData.fromTelegram(telegramUser)
        : const ProfileUserData.mock();
        log('telegramUser?.id: ${telegramUser?.id}');
    loadAvatar();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentLocale = Localizations.localeOf(context).languageCode;
  }

  WebAppUser? _resolveTelegramUser() {
    if (!kIsWeb) return null;
    
    try {
      final telegram = TelegramWebApp.instance;
      
      if (!telegram.isSupported) return null;
      return telegram.initDataUnsafe?.user;
    } on Object catch (_) {
      return null;
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
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.l10n.logoutCancel,
            style: context.textTheme.nunitoW600s16.copyWith(color: context.color.primary),
          ),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            context.localSource.clearAll();
            Navigator.pop(context);
            context.push(SettingsPage(data: 'seeeeeeeeeeeeeee'));
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
      context.pop();
      return;
    }

    setState(() => currentLocale = code);
    context
      ..setLocale(Locale(code))
      ..pop();
  }
  
  Future<void> loadAvatar() async {
    try {
      final url = await getTelegramUserAvatarUrl(7282825856);
      log('url: $url');
      if (!mounted) return;
      if (url == null) {
          setState(() {
            isLoading = false;
            error = 'User profile image topilmadi';
          });
      } else {
        setState(() {
          avatarUrl = url;
          isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        error = 'Xatolik: $e';
      });
    }
  }


  Future<String?> getTelegramUserAvatarUrl(int userId) async {

  final photosRes = await context.dios.dio.get<Map<String, dynamic>>(
    '${Urls.telegramBotUrl}/getUserProfilePhotos?user_id=$userId&limit=1',
  );

  if (photosRes.statusCode != 200) return null;
  final photosJson = photosRes.data;
  if (photosJson?['ok'] != true ||
      photosJson?['result']['total_count'] == 0) {
    return null; 
  }

  final fileId = photosJson?['result']['photos'][0][0]['file_id'];

  final fileRes = await context.dios.dio.get<Map<String, dynamic>>(
    '${Urls.telegramBotUrl}/getFile?file_id=$fileId',
  );

  if (fileRes.statusCode != 200) return null;
  final fileJson = fileRes.data;
  if (fileJson?['ok'] != true) return null;

  final filePath = fileJson?['result']['file_path'];
  profilePhotoUrl = '${Urls.telegramBotUrl}/$filePath';
  log('profilePhotoUrl: $profilePhotoUrl');
  return '${Urls.telegramBotUrl}/$filePath';
} 
}
