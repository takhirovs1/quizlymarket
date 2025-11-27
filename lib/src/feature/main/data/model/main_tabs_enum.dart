/// {@template main_tabs_enum}
/// MainTabsEnum enumeration
/// {@endtemplate}
enum MainTabsEnum implements Comparable<MainTabsEnum> {
  home('home-tab'),
  dashboard('dashboard-tab'),
  screenshots('screenshots-tab'),
  edit('edit-time'),
  profile('profile');

  /// {@macro main_tabs_enum}
  const MainTabsEnum(this.name);

  /// Creates a new instance of [MainTabsEnum] from a given string.
  static MainTabsEnum fromValue(String? value, {MainTabsEnum? fallback}) => switch (value) {
    'home-tab' => home,
    'dashboard-tab' => dashboard,
    'screenshots' => screenshots,
    'edit-time' => edit,
    'profile' => profile,
    _ => fallback ?? (throw ArgumentError.value(value)),
  };

  /// Value of the enum
  final String name;

  bool get isHomeTab => this == home;
  bool get isDashboardTab => this == dashboard;
  bool get isScreenshotsTab => this == screenshots;
  bool get isEditTab => this == edit;
  bool get isProfileTab => this == profile;

  /// Pattern matching
  T map<T>({
    required T Function() home,
    required T Function() dashboard,
    required T Function() screenshots,
    required T Function() edit,
    required T Function() profile,
  }) => switch (this) {
    MainTabsEnum.home => home(),
    MainTabsEnum.dashboard => dashboard(),
    MainTabsEnum.screenshots => screenshots(),
    MainTabsEnum.edit => edit(),
    MainTabsEnum.profile => profile(),
  };

  /// Pattern matching
  T maybeMap<T>({
    required T Function() orElse,
    T Function()? home,
    T Function()? dashboard,
    T Function()? screenshots,
    T Function()? edit,
    T Function()? profile,
  }) => map<T>(
    home: home ?? orElse,
    dashboard: dashboard ?? orElse,
    screenshots: screenshots ?? orElse,
    edit: edit ?? orElse,
    profile: profile ?? orElse,
  );

  /// Pattern matching
  T? maybeMapOrNull<T>({
    T Function()? home,
    T Function()? dashboard,
    T Function()? screenshots,
    T Function()? edit,
    T Function()? profile,
  }) => maybeMap<T?>(
    orElse: () => null,
    home: home,
    dashboard: dashboard,
    screenshots: screenshots,
    edit: edit,
    profile: profile,
  );

  @override
  int compareTo(MainTabsEnum other) => index.compareTo(other.index);

  @override
  String toString() => name;
}
