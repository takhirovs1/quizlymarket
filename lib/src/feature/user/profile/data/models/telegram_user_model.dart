import 'package:flutter/material.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../../../../auth/model/user_model.dart';

class ProfileUserData {
  const ProfileUserData({
    required this.id,
    required this.fullName,
    this.username,
    this.languageCode,
    this.balance = 0,
    this.isPremium = false,
    this.isMock = false,
  });

  const ProfileUserData.mock()
    : id = '123456',
      fullName = 'Takhirov',
      username = 'takhirovs',
      languageCode = 'uz',
      balance = 300000,
      isPremium = true,
      isMock = true;

  factory ProfileUserData.fromTelegram(WebAppUser user) => ProfileUserData(
    id: '${user.id}',
    fullName: '${user.firstName} ${user.lastName ?? ''}'.trim(),
    username: user.username,
    languageCode: user.languageCode,
    isPremium: user.isPremium ?? false,
    balance: 0,
  );

  factory ProfileUserData.fromUserModel(UserModel user) => ProfileUserData(
    id: user.userID,
    fullName: user.name,
    username: user.telegramUsername,
    balance: user.balance.round(),
    isPremium: user.role == UserRole.admin,
  );

  final String id;
  final String fullName;
  final String? username;
  final String? languageCode;
  final int balance;
  final bool isPremium;
  final bool isMock;

  String get initials {
    final source = fullName.isEmpty ? id : fullName;
    return source.characters.first.toUpperCase();
  }
}
