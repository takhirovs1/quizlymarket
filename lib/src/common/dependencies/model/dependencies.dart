import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:database/database.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:local_source/local_source.dart';
import 'package:meta/meta.dart';

import '../../../feature/settings/bloc/settings_bloc.dart';
import 'app_metadata.dart';

/// {@template dependencies}
/// Application dependencies.
/// {@endtemplate}
@immutable
final class Dependencies extends Equatable {
  /// {@macro dependencies}

  // ignore: prefer_const_constructors_in_immutables
  Dependencies();

  /// App metadata
  late final AppMetadata metadata;

  /// Local source
  late final LocalSource localeSource;

  /// [DioContainer] for network requests
  late final DioContainer dio;

  /// [SettingsBloc] for app settings
  late final SettingsBloc settingsBloc;

  /// [RepositoryContainer] for repositories
  late final RepositoryContainer repository;

  /// [BlocContainer] for blocs
  late final BlocContainer bloc;

  /// [Connectivity] for connectivity
  late final Connectivity connectivity;

  /// [AppDatabase] app database
  late final Database database;

  Dependencies copyWith({
    AppMetadata? metadata,
    LocalSource? localeSource,
    DioContainer? dio,
    SettingsBloc? settingsBloc,
    RepositoryContainer? repository,
    BlocContainer? bloc,
    Connectivity? connectivity,
    Database? database,
  }) {
    final copy = Dependencies()
      ..metadata = metadata ?? this.metadata
      ..localeSource = localeSource ?? this.localeSource
      ..dio = dio ?? this.dio
      ..settingsBloc = settingsBloc ?? this.settingsBloc
      ..repository = repository ?? this.repository
      ..bloc = bloc ?? this.bloc
      ..connectivity = connectivity ?? this.connectivity
      ..database = database ?? this.database;

    return copy;
  }

  @override
  List<Object> get props => [metadata, localeSource, dio, settingsBloc, repository, bloc, connectivity, database];

  @override
  String toString() =>
      '''
Dependencies(
  metadata: $metadata,
  localeSource: $localeSource,
  dio: $dio,
  settingsBloc: $settingsBloc,
  repository: $repository,
  bloc: $bloc,
  connectivity: $connectivity,
  database: $database
) | $hashCode
''';
}

//--- Container models --- //
/// [DioContainer] is a container for [Dio] instances.
final class DioContainer extends Equatable {
  const DioContainer({required this.dio});

  List<Dio> get all => [dio];

  final Dio dio;

  @override
  List<Object> get props => [dio];
}

/// [BlocContainer] is a container for [Bloc] instances.
final class BlocContainer extends Equatable {
  const BlocContainer();

  @override
  List<Object> get props => [];
}

/// [RepositoryContainer] is a container for [Repository] instances.
final class RepositoryContainer extends Equatable {
  const RepositoryContainer();

  @override
  List<Object> get props => [];
}
