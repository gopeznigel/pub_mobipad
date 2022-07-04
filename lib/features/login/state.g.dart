// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginState extends LoginState {
  @override
  final LoginStatusEnum status;
  @override
  final UserDto? user;
  @override
  final ActionException? exception;

  factory _$LoginState([void Function(LoginStateBuilder)? updates]) =>
      (new LoginStateBuilder()..update(updates))._build();

  _$LoginState._({required this.status, this.user, this.exception})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(status, r'LoginState', 'status');
  }

  @override
  LoginState rebuild(void Function(LoginStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginStateBuilder toBuilder() => new LoginStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginState &&
        status == other.status &&
        user == other.user &&
        exception == other.exception;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, status.hashCode), user.hashCode), exception.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginState')
          ..add('status', status)
          ..add('user', user)
          ..add('exception', exception))
        .toString();
  }
}

class LoginStateBuilder implements Builder<LoginState, LoginStateBuilder> {
  _$LoginState? _$v;

  LoginStatusEnum? _status;
  LoginStatusEnum? get status => _$this._status;
  set status(LoginStatusEnum? status) => _$this._status = status;

  UserDtoBuilder? _user;
  UserDtoBuilder get user => _$this._user ??= new UserDtoBuilder();
  set user(UserDtoBuilder? user) => _$this._user = user;

  ActionException? _exception;
  ActionException? get exception => _$this._exception;
  set exception(ActionException? exception) => _$this._exception = exception;

  LoginStateBuilder();

  LoginStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _user = $v.user?.toBuilder();
      _exception = $v.exception;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginState;
  }

  @override
  void update(void Function(LoginStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginState build() => _build();

  _$LoginState _build() {
    _$LoginState _$result;
    try {
      _$result = _$v ??
          new _$LoginState._(
              status: BuiltValueNullFieldError.checkNotNull(
                  status, r'LoginState', 'status'),
              user: _user?.build(),
              exception: exception);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'LoginState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
