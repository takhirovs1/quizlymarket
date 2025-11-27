part of 'initialization.dart';

/// Initializes the app and returns a [Dependencies] object
Future<Dependencies> $initializeDependencies({void Function(int progress, String message)? onProgress}) async {
  final dependencies = Dependencies();
  final totalSteps = _initializationSteps.length;
  var currentStep = 1;

  for (final step in _initializationSteps.entries) {
    try {
      await step.value(dependencies);

      final percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
      onProgress?.call(percent, step.key);
      info('Initialization | $currentStep/$totalSteps ($percent%) | "${step.key}"');

      currentStep++;
    } on Object catch (error, stackTrace) {
      severe('Initialization failed at step "${step.key}": $error', stackTrace);

      Error.throwWithStackTrace('Initialization failed at step "${step.key}": $error', stackTrace);
    }
  }

  return dependencies;
}

typedef _InitializationStep = FutureOr<void> Function(Dependencies dependencies);

Map<String, _InitializationStep> get _initializationSteps => <String, _InitializationStep>{
  'Platform pre-initialization': (_) {
    /// TODO: Initialize firebase
  },
  'Creating app metadata': (dependencies) => dependencies.metadata = AppMetadata(
    environment: Config.current().environment.value,
    isWeb: platform.type.js,
    isRelease: platform.buildMode.release,
    appName: Pubspec.name,
    appVersion: Pubspec.version.canonical,
    appVersionMajor: Pubspec.version.major,
    appVersionMinor: Pubspec.version.minor,
    appVersionPatch: Pubspec.version.patch,
    appBuildTimestamp: Pubspec.version.build.isNotEmpty
        ? (int.tryParse(Pubspec.version.build.firstOrNull ?? '-1') ?? -1)
        : -1,
    operatingSystem: platform.operatingSystem.name,
    processorsCount: platform.numberOfProcessors,
    appLaunchedTimestamp: DateTime.now(),
    locale: platform.locale,
    deviceVersion: platform.version,
    deviceScreenSize: ScreenUtil.screenSize().representation,
  ),
  'Database': (dependencies) async => dependencies
    ..database = Database()
    ..localeSource = await LocalSource.instance,
  'Observers': (_) {
    // Bloc.observer = const BlocLogger();
  },
  'App Initial Settings': (dependencies) {
    final localization = dependencies.localeSource.localization;
    final theme = dependencies.localeSource.theme == ThemeMode.light
        ? AppThemeData.light(FontFamily.workSans)
        : AppThemeData.dark(FontFamily.workSans);
    final hapticsEnabled = dependencies.localeSource.hapticsEnabled;

    dependencies.settingsBloc = SettingsBloc(
      settingsRepository: SettingsRepositoryImpl(localSource: dependencies.localeSource),
      initialState: SettingsState.idle(
        settings: AppSettings(localization: localization, appTheme: theme, hapticsEnabled: hapticsEnabled),
      ),
    );
  },
  'Connectivity': (dependencies) => dependencies.connectivity = Connectivity(),
  'Services': (dependencies) {
    const timeout = Duration(seconds: 8);

    final dio =
        Dio(
            BaseOptions(
              baseUrl: Config.current().apiBaseUrl,
              headers: <String, String>{
                'Api-Version': '1.0',
                'Accept': 'application/json',
                'Charset': 'utf-8',
                'App-OS': io.Platform.operatingSystem,
              },
              connectTimeout: timeout,
              receiveTimeout: timeout,
              sendTimeout: timeout,
              responseType: ResponseType.json,
            ),
          )
          ..interceptors.addAll(
            List<Interceptor>.unmodifiable(<Interceptor>[
              const HttpLogInterceptor(),

              /// The reason for adding it for only production env, because we have [Thunder] disabled in production
              if (Config.current().environment.isProduction) const TelegramBotInterceptor(),

              /// Refresh token && image type interceptor
              InterceptorsWrapper(
                onRequest: (options, handler) {
                  options.headers.addAll(<String, String>{
                    'Application-Language': dependencies.localeSource.localization.languageCode,
                    if (dependencies.localeSource.accessToken.isNotEmpty)
                      'Authorization': 'Bearer ${dependencies.localeSource.accessToken}',
                  });

                  handler.next(options);
                },
              ),
            ]),
          );

    dependencies.dio = DioContainer(dio: dio);
  },

  'Repositories': (dependencies) => dependencies.repository = const RepositoryContainer(),
  'Blocs': (dependencies) => dependencies.bloc = const BlocContainer(),
};
