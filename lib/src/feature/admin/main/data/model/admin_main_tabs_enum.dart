/// {@template main_tabs_enum}
/// MainTabsEnum enumeration
/// {@endtemplate}
enum AdminMainTabsEnum implements Comparable<AdminMainTabsEnum> {
  home('home'),
  upload('upload'),
  profile('profile');

  /// {@macro main_tabs_enum}
  const AdminMainTabsEnum(this.name);

  /// Creates a new instance of [MainTabsEnum] from a given string.
  static AdminMainTabsEnum fromValue(String? value, {AdminMainTabsEnum? fallback}) => switch (value) {
    'home' => home,
    'upload' => upload,
    'profile' => profile,
    _ => fallback ?? (throw ArgumentError.value(value)),
  };

  /// Value of the enum
  final String name;

  bool get isHomeTab => this == home;
  bool get isUploadTab => this == upload;
  bool get isProfileTab => this == profile;

  /// Pattern matching
  T map<T>({required T Function() home, required T Function() upload, required T Function() profile}) => switch (this) {
    .home => home(),
    .upload => upload(),
    .profile => profile(),
  };

  /// Pattern matching
  T maybeMap<T>({required T Function() orElse, T Function()? home, T Function()? upload, T Function()? profile}) =>
      map<T>(home: home ?? orElse, upload: upload ?? orElse, profile: profile ?? orElse);

  /// Pattern matching
  T? maybeMapOrNull<T>({T Function()? home, T Function()? upload, T Function()? profile}) =>
      maybeMap<T?>(orElse: () => null, home: home, upload: upload, profile: profile);

  @override
  int compareTo(AdminMainTabsEnum other) => index.compareTo(other.index);

  @override
  String toString() => name;
}
