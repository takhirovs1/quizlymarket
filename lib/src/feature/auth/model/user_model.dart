import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.userID,
    required this.telegramID,
    required this.name,
    required this.createdAt,
    required this.balance,
    required this.role,
    this.updatedAt,
    this.telegramUsername,
  });

  factory UserModel.fromJson(Map<String, Object?> json) => UserModel(
    userID: json['user_id'] as String,
    telegramID: json['telegram_id'] as int,
    telegramUsername: json['telegram_username'] as String?,
    name: json['full_name'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String?,
    balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
    role: UserRole.values.byName(json['role'] as String),
  );

  final String userID;
  final int telegramID;
  final String? telegramUsername;
  final String name;
  final String createdAt;
  final String? updatedAt;
  final double balance;
  final UserRole role;

  UserModel copyWith({
    String? userID,
    int? telegramID,
    ValueGetter<String?>? telegramUsername,
    String? name,
    String? createdAt,
    String? updatedAt,
    double? balance,
    UserRole? role,
  }) => UserModel(
    userID: userID ?? this.userID,
    telegramID: telegramID ?? this.telegramID,
    telegramUsername: telegramUsername != null ? telegramUsername() : this.telegramUsername,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    balance: balance ?? this.balance,
    role: role ?? this.role,
  );

  Map<String, Object?> toJson() => {
    'user_id': userID,
    'telegram_id': telegramID,
    'telegram_username': telegramUsername,
    'name': name,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'balance': balance,
    'role': role.name,
  };

  @override
  String toString() =>
      'UserModel(userID: $userID, telegramID: $telegramID, telegramUsername: $telegramUsername, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, balance: $balance, role: $role)';

  @override
  List<Object?> get props => [userID, telegramID, telegramUsername, name, createdAt, updatedAt, balance, role];
}

enum UserRole { admin, user }

/// Simple in-memory fixtures that mimic backend responses for both roles.
/// Use [useRole] to switch between the mocked admin and user profiles.
class MockUsers {
  MockUsers._();

  static const Map<UserRole, UserModel> _usersByRole = {
    UserRole.user: UserModel(
      userID: 'mock-user-id',
      telegramID: 1001,
      telegramUsername: 'mock_user',
      name: 'Quizly User',
      createdAt: '2024-01-01T08:00:00.000Z',
      updatedAt: '2024-06-10T10:15:00.000Z',
      balance: 42.5,
      role: UserRole.user,
    ),
    UserRole.admin: UserModel(
      userID: 'mock-admin-id',
      telegramID: 9001,
      telegramUsername: 'mock_admin',
      name: 'Quizly Admin',
      createdAt: '2023-11-15T09:30:00.000Z',
      updatedAt: '2024-07-01T15:45:00.000Z',
      balance: 999.99,
      role: UserRole.admin,
    ),
  };

  static const bool _preferAdminRole = bool.fromEnvironment('MOCK_USE_ADMIN_ROLE', defaultValue: false);

  static UserRole _activeRole = _preferAdminRole ? UserRole.admin : UserRole.user;

  static UserModel get activeUser => _usersByRole[_activeRole]!;

  static UserRole get activeRole => _activeRole;

  static void useRole(UserRole role) => _activeRole = role;

  static UserModel byRole(UserRole role) => _usersByRole[role]!;

  static Iterable<UserModel> get values => _usersByRole.values;
}
