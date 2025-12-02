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
