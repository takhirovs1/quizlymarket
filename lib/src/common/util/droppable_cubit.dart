import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DroppableCubit<S extends Object> extends Cubit<S> {
  DroppableCubit(super.initialState);

  @nonVirtual
  bool get isProcessing => _$processingCalls > 0;
  int _$processingCalls = 0;

  @nonVirtual
  bool get isDisposed => _$isDisposed;
  bool _$isDisposed = false;

  @protected
  @mustCallSuper
  void handle(
    FutureOr<void> Function() handler, {
    FutureOr<void> Function(Object error, StackTrace stackTrace)? errorHandler,
    FutureOr<void> Function()? doneHandler,
  }) => runZonedGuarded<void>(() async {
    if (isDisposed || isProcessing) return;
    _$processingCalls++;
    try {
      await handler();
    } on Object catch (error, stackTrace) {
      onError(error, stackTrace);
      await Future<void>(() async {
        await errorHandler?.call(error, stackTrace);
      }).catchError(onError);
    } finally {
      await Future<void>(() async {
        await doneHandler?.call();
      }).catchError(onError);
      _$processingCalls--;
    }
  }, onError);

  @override
  @mustCallSuper
  Future<void> close() => super.close().whenComplete(() => _$isDisposed = true);
}
