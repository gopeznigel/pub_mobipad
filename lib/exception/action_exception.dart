import 'package:flutter/foundation.dart';

@immutable
class ActionException implements Exception {
  const ActionException(this.exception, this.action);

  final Exception? exception;
  final Object? action;

  @override
  String toString() =>
      'ActionException{action: $action, exception: $exception}';
}
