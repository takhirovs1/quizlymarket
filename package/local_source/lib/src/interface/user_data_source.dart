part of '../local_source.dart';

/// {@template user_data_source}
/// Data source for the app user.
/// {@endtemplate}
abstract interface class UserDataSource {
  /// {@macro user_data_source}
  const UserDataSource._();

  String get userID;
  Future<void> setUserID(String userID);

  String get accessToken;
  Future<void> setAccessToken(String accessToken);

  String get refreshToken;
  Future<void> setRefreshToken(String refreshToken);

  bool get isUserAuthenticated;

  bool get onboardingCompleted;
  Future<void> setOnboardingCompleted(bool completed);
}

/// {@template user_data_source_mixin}
/// Mixin for the app user data source.
/// {@endtemplate}
base mixin UserDataSourceMixin on PreferenceDao implements UserDataSource {
  /// Entries
  PreferenceEntry<String> get _userIdKey => stringEntry(key: 'user.id');
  PreferenceEntry<String> get _accessTokenKey => stringEntry(key: 'user.access_token');
  PreferenceEntry<String> get _refreshTokenKey => stringEntry(key: 'user.refresh_key');
  PreferenceEntry<bool> get _onboardingCompletedKey => boolEntry(key: 'user.onboarding_completed');

  /// --- Getters --- ///
  @override
  bool get isUserAuthenticated => accessToken.isNotEmpty && refreshToken.isNotEmpty;

  /// Encrypted values using [SecureStorage]
  @override
  String get userID => readCachedOrDecrypted(_userIdKey);

  @override
  String get accessToken => readCachedOrDecrypted(_accessTokenKey);

  @override
  String get refreshToken => readCachedOrDecrypted(_refreshTokenKey);

  @override
  bool get onboardingCompleted => readFromCache<bool>(_onboardingCompletedKey) ?? false;

  /// --- Setters --- ///
  /// Encrypted values using [SecureStorage]
  @override
  Future<void> setUserID(String userID) async {
    cache[_userIdKey.key] = userID;
    await SecureStorage.setUsingEncryption(userID, entry: _userIdKey);
  }

  @override
  Future<void> setAccessToken(String accessToken) async {
    cache[_accessTokenKey.key] = accessToken;
    await SecureStorage.setUsingEncryption(accessToken, entry: _accessTokenKey);
  }

  @override
  Future<void> setRefreshToken(String refreshToken) async {
    cache[_refreshTokenKey.key] = refreshToken;
    await SecureStorage.setUsingEncryption(refreshToken, entry: _refreshTokenKey);
  }

  @override
  Future<void> setOnboardingCompleted(bool completed) async {
    cache[_onboardingCompletedKey.key] = completed;
    await _onboardingCompletedKey.set(completed);
  }
}
