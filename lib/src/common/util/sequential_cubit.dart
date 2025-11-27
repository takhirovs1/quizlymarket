import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logger.dart';

abstract class SequentialCubit<S extends Object> extends Cubit<S> {
  SequentialCubit(super.initialState);

  final _ControllerEventQueue _eventQueue = _ControllerEventQueue();

  /// Whether the event queue is closed.
  @nonVirtual
  bool get isProcessing => _eventQueue.length > 0;

  /// Fire when the event queue is empty.
  Future<void> get done => _eventQueue._processing ?? SynchronousFuture<void>(null);

  /// Use this method to handle asynchronous logic inside the cubit.
  @protected
  @mustCallSuper
  Future<R?> handle<R extends Object?>(
    FutureOr<R> Function(void Function(S state) emit) handler, {
    FutureOr<void> Function(void Function(S state) emit, Object error, StackTrace stackTrace)? errorHandler,
    FutureOr<void> Function(void Function(S state) emit)? doneHandler,
  }) => _eventQueue
      .push<R?>(() {
        final completer = Completer<R?>();
        void emit(S state) {
          if (isClosed || completer.isCompleted) return;
          super.emit(state);
        }

        Future<void> onError(Object error, StackTrace stackTrace) async {
          await Future<void>.delayed(Duration.zero);
          try {
            super.onError(error, stackTrace);
            if (isClosed || completer.isCompleted) return;
            await errorHandler?.call(emit, error, stackTrace);
            severe('[$runtimeType] Error while processing event: $error');
          } on Object catch (error, stackTrace) {
            super.onError(error, stackTrace);
            severe('[$runtimeType] Object error while processing event: $error');
          }
        }

        runZonedGuarded<void>(() async {
          await Future<void>.delayed(Duration.zero);

          if (isClosed) return;
          R? result;
          try {
            result = await handler(emit);
          } on Object catch (error, stackTrace) {
            await onError(error, stackTrace);
          } finally {
            try {
              await doneHandler?.call(emit);
            } on Object catch (error, stackTrace) {
              super.onError(error, stackTrace);
            }
            completer.complete(result);
          }
        }, onError);
        return completer.future;
      })
      .catchError((_, __) => null);

  @override
  @mustCallSuper
  Future<void> close() => super.close().whenComplete(_eventQueue.close);
}

final class _ControllerEventQueue {
  _ControllerEventQueue();

  final DoubleLinkedQueue<_SequentialTask<Object?>> _queue = DoubleLinkedQueue<_SequentialTask<Object?>>();
  Future<void>? _processing;
  bool _isClosed = false;

  /// Event queue length.

  int get length => _queue.length;

  /// Push it at the end of the queue.

  Future<T> push<T>(FutureOr<T> Function() fn) {
    final task = _SequentialTask<T>(fn);
    _queue.add(task);
    _exec();
    return task.future;
  }

  /// Mark the queue as closed.
  /// The queue will be processed until it's empty.
  /// But all new and current events will be rejected with [WSClientClosed].
  FutureOr<void> close() async {
    _isClosed = true;
    await _processing;
  }

  /// Execute the queue.
  void _exec() => _processing ??= Future.doWhile(() async {
    final event = _queue.firstOrNull;
    try {
      if (_isClosed) {
        event?.reject(StateError('Controller\'s event queue are disposed'), StackTrace.current);
      } else {
        await event?.call();
      }
    } on Object catch (error, stackTrace) {
      /* warning(
            error,
            stackTrace,
            'Error while processing event "${event.id}"',
          ); */
      Future<void>.sync(() => event?.reject(error, stackTrace)).ignore();
    }
    _queue.removeFirst();
    final isEmpty = _queue.isEmpty;
    if (isEmpty) _processing = null;
    return !isEmpty;
  });
}

class _SequentialTask<T> {
  _SequentialTask(FutureOr<T> Function() fn) : _fn = fn, _completer = Completer<T>();

  final Completer<T> _completer;

  final FutureOr<T> Function() _fn;

  Future<T> get future => _completer.future;

  FutureOr<T> call() async {
    final result = await _fn();
    if (!_completer.isCompleted) {
      _completer.complete(result);
    }
    return result;
  }

  void reject(Object error, [StackTrace? stackTrace]) {
    if (_completer.isCompleted) return;
    _completer.completeError(error, stackTrace);
  }
}
