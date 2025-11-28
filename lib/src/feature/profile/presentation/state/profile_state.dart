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
  String? _profilePhotoUrl;

  String get profilePhotoUrl => _profilePhotoUrl ?? profileData.photoUrl ?? '';

  @override
  void initState() {
    super.initState();
    final telegramUser = _resolveTelegramUser();
    isTelegramUser = telegramUser != null;
    profileData = telegramUser != null
        ? ProfileUserData.fromTelegram(telegramUser)
        : const ProfileUserData.mock();
    _loadUserProfilePhoto();
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

  Future<void> _loadUserProfilePhoto() async {
    log('isTelegramUser: $isTelegramUser');
    if (!isTelegramUser) return;

    final url = await getUserProfileUrl(profileData.id);
    log('url: $url');
    if (!mounted || url == null || url.isEmpty) return;
    

    setState(() {
      _profilePhotoUrl = url;
    });
  }

  Future<String?> getUserProfileUrl(int userId) async {
    try {
      final response = await context.dios.dio.get<Map<String, dynamic>>(
        '${Urls.telegramBotUrl}/getUserProfilePhotos',
        queryParameters: <String, dynamic>{
          'user_id': userId,
          'limit': 1,
        },
      );

      final data = response.data;
      if (response.statusCode != 200 || data == null || data['ok'] != true) {
        return null;
      }

      final photos = data['result']?['photos'] as List<dynamic>?;
      if (photos == null || photos.isEmpty) return null;

      final firstSizes = photos.first as List<dynamic>;
      if (firstSizes.isEmpty) return null;

      final firstPhoto = firstSizes.first as Map<String, dynamic>;
      final fileId = firstPhoto['file_id'] as String?;
      if (fileId == null || fileId.isEmpty) return null;

      // 2) Get the file path by file_id
      final fileResponse = await context.dios.dio.get<Map<String, dynamic>>(
        '${Urls.telegramBotUrl}/getFile',
        queryParameters: <String, dynamic>{
          'file_id': fileId,
        },
      );

      final fileData = fileResponse.data;
      if (fileResponse.statusCode != 200 ||
          fileData == null ||
          fileData['ok'] != true) {
        return null;
      }

      final filePath = fileData['result']?['file_path'] as String?;
      if (filePath == null || filePath.isEmpty) return null;

      // 3) Build direct link to the image file
      return 'https://api.telegram.org/file/bot${Urls.telegramBotToken}/$filePath';
    } on Object {
      return null;
    }
  }
}
