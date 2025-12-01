/// {@template main_tabs_enum}
/// MainTabsEnum enumeration
/// {@endtemplate}
enum MainTabsEnum implements Comparable<MainTabsEnum> {
  home('home'),
  cart('cart'),
  profile('profile');

  /// {@macro main_tabs_enum}
  const MainTabsEnum(this.name);

  /// Creates a new instance of [MainTabsEnum] from a given string.
  static MainTabsEnum fromValue(String? value, {MainTabsEnum? fallback}) => switch (value) {
    'home' => home,
    'cart' => cart,
    'profile' => profile,
    _ => fallback ?? (throw ArgumentError.value(value)),
  };

  /// Value of the enum
  final String name;

  bool get isHomeTab => this == home;
  bool get isCartTab => this == cart;
  bool get isProfileTab => this == profile;

  /// Pattern matching
  T map<T>({required T Function() home, required T Function() cart, required T Function() profile}) =>
      switch (this) {
        .home => home(),
        .cart => cart(),
        .profile => profile(),
      };

  /// Pattern matching
  T maybeMap<T>({required T Function() orElse, T Function()? home, T Function()? cart, T Function()? profile}) =>
      map<T>(home: home ?? orElse, cart: cart ?? orElse, profile: profile ?? orElse);

  /// Pattern matching
  T? maybeMapOrNull<T>({T Function()? home, T Function()? cart, T Function()? profile}) =>
      maybeMap<T?>(orElse: () => null, home: home, cart: cart, profile: profile);

  @override
  int compareTo(MainTabsEnum other) => index.compareTo(other.index);

  @override
  String toString() => name;
}
