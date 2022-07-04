// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReminderState extends ReminderState {
  @override
  final bool onRepeat;
  @override
  final DateTime? selectedDate;
  @override
  final material.TimeOfDay? selectedTime;
  @override
  final ReminderDto? reminder;
  @override
  final bool isBusy;
  @override
  final ActionException? exception;

  factory _$ReminderState([void Function(ReminderStateBuilder)? updates]) =>
      (new ReminderStateBuilder()..update(updates))._build();

  _$ReminderState._(
      {required this.onRepeat,
      this.selectedDate,
      this.selectedTime,
      this.reminder,
      required this.isBusy,
      this.exception})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        onRepeat, r'ReminderState', 'onRepeat');
    BuiltValueNullFieldError.checkNotNull(isBusy, r'ReminderState', 'isBusy');
  }

  @override
  ReminderState rebuild(void Function(ReminderStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReminderStateBuilder toBuilder() => new ReminderStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReminderState &&
        onRepeat == other.onRepeat &&
        selectedDate == other.selectedDate &&
        selectedTime == other.selectedTime &&
        reminder == other.reminder &&
        isBusy == other.isBusy &&
        exception == other.exception;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, onRepeat.hashCode), selectedDate.hashCode),
                    selectedTime.hashCode),
                reminder.hashCode),
            isBusy.hashCode),
        exception.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReminderState')
          ..add('onRepeat', onRepeat)
          ..add('selectedDate', selectedDate)
          ..add('selectedTime', selectedTime)
          ..add('reminder', reminder)
          ..add('isBusy', isBusy)
          ..add('exception', exception))
        .toString();
  }
}

class ReminderStateBuilder
    implements Builder<ReminderState, ReminderStateBuilder> {
  _$ReminderState? _$v;

  bool? _onRepeat;
  bool? get onRepeat => _$this._onRepeat;
  set onRepeat(bool? onRepeat) => _$this._onRepeat = onRepeat;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _$this._selectedDate;
  set selectedDate(DateTime? selectedDate) =>
      _$this._selectedDate = selectedDate;

  material.TimeOfDay? _selectedTime;
  material.TimeOfDay? get selectedTime => _$this._selectedTime;
  set selectedTime(material.TimeOfDay? selectedTime) =>
      _$this._selectedTime = selectedTime;

  ReminderDtoBuilder? _reminder;
  ReminderDtoBuilder get reminder =>
      _$this._reminder ??= new ReminderDtoBuilder();
  set reminder(ReminderDtoBuilder? reminder) => _$this._reminder = reminder;

  bool? _isBusy;
  bool? get isBusy => _$this._isBusy;
  set isBusy(bool? isBusy) => _$this._isBusy = isBusy;

  ActionException? _exception;
  ActionException? get exception => _$this._exception;
  set exception(ActionException? exception) => _$this._exception = exception;

  ReminderStateBuilder();

  ReminderStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _onRepeat = $v.onRepeat;
      _selectedDate = $v.selectedDate;
      _selectedTime = $v.selectedTime;
      _reminder = $v.reminder?.toBuilder();
      _isBusy = $v.isBusy;
      _exception = $v.exception;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReminderState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReminderState;
  }

  @override
  void update(void Function(ReminderStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReminderState build() => _build();

  _$ReminderState _build() {
    _$ReminderState _$result;
    try {
      _$result = _$v ??
          new _$ReminderState._(
              onRepeat: BuiltValueNullFieldError.checkNotNull(
                  onRepeat, r'ReminderState', 'onRepeat'),
              selectedDate: selectedDate,
              selectedTime: selectedTime,
              reminder: _reminder?.build(),
              isBusy: BuiltValueNullFieldError.checkNotNull(
                  isBusy, r'ReminderState', 'isBusy'),
              exception: exception);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'reminder';
        _reminder?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReminderState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
