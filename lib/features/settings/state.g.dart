// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SettingsState extends SettingsState {
  @override
  final bool isBusy;
  @override
  final String selectedSorting;
  @override
  final String selectedDateTimeDisplay;
  @override
  final int selectedFontSize;
  @override
  final ActionException? exception;

  factory _$SettingsState([void Function(SettingsStateBuilder)? updates]) =>
      (new SettingsStateBuilder()..update(updates))._build();

  _$SettingsState._(
      {required this.isBusy,
      required this.selectedSorting,
      required this.selectedDateTimeDisplay,
      required this.selectedFontSize,
      this.exception})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(isBusy, r'SettingsState', 'isBusy');
    BuiltValueNullFieldError.checkNotNull(
        selectedSorting, r'SettingsState', 'selectedSorting');
    BuiltValueNullFieldError.checkNotNull(
        selectedDateTimeDisplay, r'SettingsState', 'selectedDateTimeDisplay');
    BuiltValueNullFieldError.checkNotNull(
        selectedFontSize, r'SettingsState', 'selectedFontSize');
  }

  @override
  SettingsState rebuild(void Function(SettingsStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsStateBuilder toBuilder() => new SettingsStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingsState &&
        isBusy == other.isBusy &&
        selectedSorting == other.selectedSorting &&
        selectedDateTimeDisplay == other.selectedDateTimeDisplay &&
        selectedFontSize == other.selectedFontSize &&
        exception == other.exception;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, isBusy.hashCode), selectedSorting.hashCode),
                selectedDateTimeDisplay.hashCode),
            selectedFontSize.hashCode),
        exception.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SettingsState')
          ..add('isBusy', isBusy)
          ..add('selectedSorting', selectedSorting)
          ..add('selectedDateTimeDisplay', selectedDateTimeDisplay)
          ..add('selectedFontSize', selectedFontSize)
          ..add('exception', exception))
        .toString();
  }
}

class SettingsStateBuilder
    implements Builder<SettingsState, SettingsStateBuilder> {
  _$SettingsState? _$v;

  bool? _isBusy;
  bool? get isBusy => _$this._isBusy;
  set isBusy(bool? isBusy) => _$this._isBusy = isBusy;

  String? _selectedSorting;
  String? get selectedSorting => _$this._selectedSorting;
  set selectedSorting(String? selectedSorting) =>
      _$this._selectedSorting = selectedSorting;

  String? _selectedDateTimeDisplay;
  String? get selectedDateTimeDisplay => _$this._selectedDateTimeDisplay;
  set selectedDateTimeDisplay(String? selectedDateTimeDisplay) =>
      _$this._selectedDateTimeDisplay = selectedDateTimeDisplay;

  int? _selectedFontSize;
  int? get selectedFontSize => _$this._selectedFontSize;
  set selectedFontSize(int? selectedFontSize) =>
      _$this._selectedFontSize = selectedFontSize;

  ActionException? _exception;
  ActionException? get exception => _$this._exception;
  set exception(ActionException? exception) => _$this._exception = exception;

  SettingsStateBuilder();

  SettingsStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isBusy = $v.isBusy;
      _selectedSorting = $v.selectedSorting;
      _selectedDateTimeDisplay = $v.selectedDateTimeDisplay;
      _selectedFontSize = $v.selectedFontSize;
      _exception = $v.exception;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SettingsState;
  }

  @override
  void update(void Function(SettingsStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SettingsState build() => _build();

  _$SettingsState _build() {
    final _$result = _$v ??
        new _$SettingsState._(
            isBusy: BuiltValueNullFieldError.checkNotNull(
                isBusy, r'SettingsState', 'isBusy'),
            selectedSorting: BuiltValueNullFieldError.checkNotNull(
                selectedSorting, r'SettingsState', 'selectedSorting'),
            selectedDateTimeDisplay: BuiltValueNullFieldError.checkNotNull(
                selectedDateTimeDisplay,
                r'SettingsState',
                'selectedDateTimeDisplay'),
            selectedFontSize: BuiltValueNullFieldError.checkNotNull(
                selectedFontSize, r'SettingsState', 'selectedFontSize'),
            exception: exception);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
