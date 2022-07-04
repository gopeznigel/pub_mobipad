// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppState extends AppState {
  @override
  final LoginState loginState;
  @override
  final HomeState homeState;
  @override
  final NoteState noteState;
  @override
  final ReminderState reminderState;
  @override
  final SettingsState settingsState;
  @override
  final ForgotPasswordState forgotPasswordState;

  factory _$AppState([void Function(AppStateBuilder)? updates]) =>
      (new AppStateBuilder()..update(updates))._build();

  _$AppState._(
      {required this.loginState,
      required this.homeState,
      required this.noteState,
      required this.reminderState,
      required this.settingsState,
      required this.forgotPasswordState})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        loginState, r'AppState', 'loginState');
    BuiltValueNullFieldError.checkNotNull(homeState, r'AppState', 'homeState');
    BuiltValueNullFieldError.checkNotNull(noteState, r'AppState', 'noteState');
    BuiltValueNullFieldError.checkNotNull(
        reminderState, r'AppState', 'reminderState');
    BuiltValueNullFieldError.checkNotNull(
        settingsState, r'AppState', 'settingsState');
    BuiltValueNullFieldError.checkNotNull(
        forgotPasswordState, r'AppState', 'forgotPasswordState');
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        loginState == other.loginState &&
        homeState == other.homeState &&
        noteState == other.noteState &&
        reminderState == other.reminderState &&
        settingsState == other.settingsState &&
        forgotPasswordState == other.forgotPasswordState;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, loginState.hashCode), homeState.hashCode),
                    noteState.hashCode),
                reminderState.hashCode),
            settingsState.hashCode),
        forgotPasswordState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppState')
          ..add('loginState', loginState)
          ..add('homeState', homeState)
          ..add('noteState', noteState)
          ..add('reminderState', reminderState)
          ..add('settingsState', settingsState)
          ..add('forgotPasswordState', forgotPasswordState))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState? _$v;

  LoginStateBuilder? _loginState;
  LoginStateBuilder get loginState =>
      _$this._loginState ??= new LoginStateBuilder();
  set loginState(LoginStateBuilder? loginState) =>
      _$this._loginState = loginState;

  HomeStateBuilder? _homeState;
  HomeStateBuilder get homeState =>
      _$this._homeState ??= new HomeStateBuilder();
  set homeState(HomeStateBuilder? homeState) => _$this._homeState = homeState;

  NoteStateBuilder? _noteState;
  NoteStateBuilder get noteState =>
      _$this._noteState ??= new NoteStateBuilder();
  set noteState(NoteStateBuilder? noteState) => _$this._noteState = noteState;

  ReminderStateBuilder? _reminderState;
  ReminderStateBuilder get reminderState =>
      _$this._reminderState ??= new ReminderStateBuilder();
  set reminderState(ReminderStateBuilder? reminderState) =>
      _$this._reminderState = reminderState;

  SettingsStateBuilder? _settingsState;
  SettingsStateBuilder get settingsState =>
      _$this._settingsState ??= new SettingsStateBuilder();
  set settingsState(SettingsStateBuilder? settingsState) =>
      _$this._settingsState = settingsState;

  ForgotPasswordStateBuilder? _forgotPasswordState;
  ForgotPasswordStateBuilder get forgotPasswordState =>
      _$this._forgotPasswordState ??= new ForgotPasswordStateBuilder();
  set forgotPasswordState(ForgotPasswordStateBuilder? forgotPasswordState) =>
      _$this._forgotPasswordState = forgotPasswordState;

  AppStateBuilder();

  AppStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _loginState = $v.loginState.toBuilder();
      _homeState = $v.homeState.toBuilder();
      _noteState = $v.noteState.toBuilder();
      _reminderState = $v.reminderState.toBuilder();
      _settingsState = $v.settingsState.toBuilder();
      _forgotPasswordState = $v.forgotPasswordState.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppState build() => _build();

  _$AppState _build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              loginState: loginState.build(),
              homeState: homeState.build(),
              noteState: noteState.build(),
              reminderState: reminderState.build(),
              settingsState: settingsState.build(),
              forgotPasswordState: forgotPasswordState.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'loginState';
        loginState.build();
        _$failedField = 'homeState';
        homeState.build();
        _$failedField = 'noteState';
        noteState.build();
        _$failedField = 'reminderState';
        reminderState.build();
        _$failedField = 'settingsState';
        settingsState.build();
        _$failedField = 'forgotPasswordState';
        forgotPasswordState.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
