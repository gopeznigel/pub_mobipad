import 'package:meta/meta.dart';

@immutable
class ActionException implements Exception {
  const ActionException(this.exception, this.action)
      : assert(exception != null),
        assert(action != null);

  final Exception exception;
  final Object action;

  @override
  String toString() =>
      'ActionException{action: $action, exception: $exception}';
}
