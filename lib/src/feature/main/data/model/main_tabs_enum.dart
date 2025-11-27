/// {@template main_tabs_enum}
/// MainTabsEnum enumeration
/// {@endtemplate}
enum MainTabsEnum implements Comparable<MainTabsEnum> {
  home('home'),
  catalog('catalog'),
  profile('profile');

  /// {@macro main_tabs_enum}
  const MainTabsEnum(this.name);

  /// Creates a new instance of [MainTabsEnum] from a given string.
  static MainTabsEnum fromValue(String? value, {MainTabsEnum? fallback}) => switch (value) {
    'home' => home,
    'catalog' => catalog,
    'profile' => profile,
    _ => fallback ?? (throw ArgumentError.value(value)),
  };

  /// Value of the enum
  final String name;

  bool get isHomeTab => this == home;
  bool get isCatalogTab => this == catalog;
  bool get isProfileTab => this == profile;

  /// Pattern matching
  T map<T>({
    required T Function() home,
    required T Function() catalog,
    required T Function() profile,
  }) => switch (this) {
    MainTabsEnum.home => home(),
    MainTabsEnum.catalog => catalog(),
    MainTabsEnum.profile => profile(),
  };

  /// Pattern matching
  T maybeMap<T>({
    required T Function() orElse,
    T Function()? home,
    T Function()? catalog,
    T Function()? profile,
  }) => map<T>(
    home: home ?? orElse,
    catalog: catalog ?? orElse,
    profile: profile ?? orElse,
  );

  /// Pattern matching
  T? maybeMapOrNull<T>({
    T Function()? home,
    T Function()? catalog,
    T Function()? profile,
  }) => maybeMap<T?>(
    orElse: () => null,
    home: home,
    catalog: catalog,
    profile: profile,
  );

  @override
  int compareTo(MainTabsEnum other) => index.compareTo(other.index);

  @override
  String toString() => name;
}
