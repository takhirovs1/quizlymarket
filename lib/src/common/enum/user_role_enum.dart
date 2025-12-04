enum UserRole {
  admin,
  user;

  bool get isAdmin => this == .admin;
  bool get isUser => this == .user;
}
