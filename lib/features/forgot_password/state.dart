import 'package:built_value/built_value.dart';
import 'package:mobipad/exception/action_exception.dart';

part 'state.g.dart';

abstract class ForgotPasswordState
    implements Built<ForgotPasswordState, ForgotPasswordStateBuilder> {
  factory ForgotPasswordState(
          [void Function(ForgotPasswordStateBuilder b) updates]) =
      _$ForgotPasswordState;

  factory ForgotPasswordState.initial() => _$ForgotPasswordState._(
        isBusy: false,
      );

  ForgotPasswordState._();

  bool get isBusy;
  ActionException? get exception;
}
