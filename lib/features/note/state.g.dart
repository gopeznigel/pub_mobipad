// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NoteState extends NoteState {
  @override
  final NoteModeEnum noteMode;
  @override
  final NoteStatusEnum status;
  @override
  final NoteDto? note;
  @override
  final ActionException? exception;

  factory _$NoteState([void Function(NoteStateBuilder)? updates]) =>
      (new NoteStateBuilder()..update(updates))._build();

  _$NoteState._(
      {required this.noteMode, required this.status, this.note, this.exception})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(noteMode, r'NoteState', 'noteMode');
    BuiltValueNullFieldError.checkNotNull(status, r'NoteState', 'status');
  }

  @override
  NoteState rebuild(void Function(NoteStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NoteStateBuilder toBuilder() => new NoteStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NoteState &&
        noteMode == other.noteMode &&
        status == other.status &&
        note == other.note &&
        exception == other.exception;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, noteMode.hashCode), status.hashCode), note.hashCode),
        exception.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NoteState')
          ..add('noteMode', noteMode)
          ..add('status', status)
          ..add('note', note)
          ..add('exception', exception))
        .toString();
  }
}

class NoteStateBuilder implements Builder<NoteState, NoteStateBuilder> {
  _$NoteState? _$v;

  NoteModeEnum? _noteMode;
  NoteModeEnum? get noteMode => _$this._noteMode;
  set noteMode(NoteModeEnum? noteMode) => _$this._noteMode = noteMode;

  NoteStatusEnum? _status;
  NoteStatusEnum? get status => _$this._status;
  set status(NoteStatusEnum? status) => _$this._status = status;

  NoteDtoBuilder? _note;
  NoteDtoBuilder get note => _$this._note ??= new NoteDtoBuilder();
  set note(NoteDtoBuilder? note) => _$this._note = note;

  ActionException? _exception;
  ActionException? get exception => _$this._exception;
  set exception(ActionException? exception) => _$this._exception = exception;

  NoteStateBuilder();

  NoteStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _noteMode = $v.noteMode;
      _status = $v.status;
      _note = $v.note?.toBuilder();
      _exception = $v.exception;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoteState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NoteState;
  }

  @override
  void update(void Function(NoteStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NoteState build() => _build();

  _$NoteState _build() {
    _$NoteState _$result;
    try {
      _$result = _$v ??
          new _$NoteState._(
              noteMode: BuiltValueNullFieldError.checkNotNull(
                  noteMode, r'NoteState', 'noteMode'),
              status: BuiltValueNullFieldError.checkNotNull(
                  status, r'NoteState', 'status'),
              note: _note?.build(),
              exception: exception);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'note';
        _note?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'NoteState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
