// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ForgotPasswordState extends ForgotPasswordState {
  @override
  final bool isBusy;
  @override
  final ActionException? exception;

  factory _$ForgotPasswordState(
          [void Function(ForgotPasswordStateBuilder)? updates]) =>
      (new ForgotPasswordStateBuilder()..update(updates))._build();

  _$ForgotPasswordState._({required this.isBusy, this.exception}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        isBusy, r'ForgotPasswordState', 'isBusy');
  }

  @override
  ForgotPasswordState rebuild(
          void Function(ForgotPasswordStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ForgotPasswordStateBuilder toBuilder() =>
      new ForgotPasswordStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForgotPasswordState &&
        isBusy == other.isBusy &&
        exception == other.exception;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, isBusy.hashCode), exception.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ForgotPasswordState')
          ..add('isBusy', isBusy)
          ..add('exception', exception))
        .toString();
  }
}

class ForgotPasswordStateBuilder
    implements Builder<ForgotPasswordState, ForgotPasswordStateBuilder> {
  _$ForgotPasswordState? _$v;

  bool? _isBusy;
  bool? get isBusy => _$this._isBusy;
  set isBusy(bool? isBusy) => _$this._isBusy = isBusy;

  ActionException? _exception;
  ActionException? get exception => _$this._exception;
  set exception(ActionException? exception) => _$this._exception = exception;

  ForgotPasswordStateBuilder();

  ForgotPasswordStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isBusy = $v.isBusy;
      _exception = $v.exception;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForgotPasswordState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ForgotPasswordState;
  }

  @override
  void update(void Function(ForgotPasswordStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ForgotPasswordState build() => _build();

  _$ForgotPasswordState _build() {
    final _$result = _$v ??
        new _$ForgotPasswordState._(
            isBusy: BuiltValueNullFieldError.checkNotNull(
                isBusy, r'ForgotPasswordState', 'isBusy'),
            exception: exception);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
