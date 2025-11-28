
import 'package:flutter/material.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

class ProfileUserData {
  const ProfileUserData({
    required this.id,
    required this.firstName,
    this.lastName,
    this.username,
    this.photoUrl,
    this.languageCode,
    this.balance,
    this.isPremium = false,
    this.isMock = false,
  });

  const ProfileUserData.mock()
    : id = 123456,
      firstName = 'Takhirov',
      lastName = null,
      username = 'takhirovs',
      photoUrl = 'https://farm4.staticflickr.com/3049/2327691528_f060ee2d1f.jpg',
      languageCode = 'uz',
      balance = 300000,
      isPremium = true,
      isMock = true;

  factory ProfileUserData.fromTelegram(WebAppUser user) => ProfileUserData(
    id: user.id,
    firstName: user.firstName,
    lastName: user.lastName,
    username: user.username,
    photoUrl: user.photoUrl,
    languageCode: user.languageCode,
    isPremium: user.isPremium ?? false,
    balance: 0,
  );

  final int id;
  final String firstName;
  final String? lastName;
  final String? username;
  final String? photoUrl;
  final String? languageCode;
  final int? balance;
  final bool isPremium;
  final bool isMock;

  String get fullName {
    final segments = <String>[
      firstName,
      if ((lastName ?? '').trim().isNotEmpty) lastName!.trim(),
    ];
    final concatenated = segments.join(' ').trim();
    return concatenated.isEmpty ? firstName : concatenated;
  }

  String get initials {
    final source = fullName.isEmpty ? firstName : fullName;
    return source.characters.first.toUpperCase();
  }
}
