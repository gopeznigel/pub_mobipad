// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtos.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NoteModeEnum _$note = const NoteModeEnum._('note');
const NoteModeEnum _$todo = const NoteModeEnum._('todo');

NoteModeEnum _$noteModeEnumValueOf(String name) {
  switch (name) {
    case 'note':
      return _$note;
    case 'todo':
      return _$todo;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<NoteModeEnum> _$noteModeEnumValues =
    new BuiltSet<NoteModeEnum>(const <NoteModeEnum>[
  _$note,
  _$todo,
]);

const NoteCategoryEnum _$active = const NoteCategoryEnum._('active');
const NoteCategoryEnum _$archived = const NoteCategoryEnum._('archived');
const NoteCategoryEnum _$trashed = const NoteCategoryEnum._('trashed');

NoteCategoryEnum _$noteCategoryEnumValueOf(String name) {
  switch (name) {
    case 'active':
      return _$active;
    case 'archived':
      return _$archived;
    case 'trashed':
      return _$trashed;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<NoteCategoryEnum> _$noteCategoryEnumValues =
    new BuiltSet<NoteCategoryEnum>(const <NoteCategoryEnum>[
  _$active,
  _$archived,
  _$trashed,
]);

Serializer<NoteDto> _$noteDtoSerializer = new _$NoteDtoSerializer();
Serializer<TodoDto> _$todoDtoSerializer = new _$TodoDtoSerializer();
Serializer<ReminderDto> _$reminderDtoSerializer = new _$ReminderDtoSerializer();
Serializer<ReminderDayDto> _$reminderDayDtoSerializer =
    new _$ReminderDayDtoSerializer();
Serializer<NoteModeEnum> _$noteModeEnumSerializer =
    new _$NoteModeEnumSerializer();
Serializer<NoteCategoryEnum> _$noteCategoryEnumSerializer =
    new _$NoteCategoryEnumSerializer();

class _$NoteDtoSerializer implements StructuredSerializer<NoteDto> {
  @override
  final Iterable<Type> types = const [NoteDto, _$NoteDto];
  @override
  final String wireName = 'NoteDto';

  @override
  Iterable<Object?> serialize(Serializers serializers, NoteDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'pinned',
      serializers.serialize(object.pinned, specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.todoList;
    if (value != null) {
      result
        ..add('todoList')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(TodoDto)])));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.dateCreated;
    if (value != null) {
      result
        ..add('dateCreated')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.dateModified;
    if (value != null) {
      result
        ..add('dateModified')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.dateDeleted;
    if (value != null) {
      result
        ..add('dateDeleted')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.dateArchived;
    if (value != null) {
      result
        ..add('dateArchived')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.reminder;
    if (value != null) {
      result
        ..add('reminder')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(ReminderDto)));
    }
    return result;
  }

  @override
  NoteDto deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NoteDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'todoList':
          result.todoList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TodoDto)]))!
              as BuiltList<Object?>);
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'dateCreated':
          result.dateCreated = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'dateModified':
          result.dateModified = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'dateDeleted':
          result.dateDeleted = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'dateArchived':
          result.dateArchived = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'pinned':
          result.pinned = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'reminder':
          result.reminder.replace(serializers.deserialize(value,
              specifiedType: const FullType(ReminderDto))! as ReminderDto);
          break;
      }
    }

    return result.build();
  }
}

class _$TodoDtoSerializer implements StructuredSerializer<TodoDto> {
  @override
  final Iterable<Type> types = const [TodoDto, _$TodoDto];
  @override
  final String wireName = 'TodoDto';

  @override
  Iterable<Object?> serialize(Serializers serializers, TodoDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.todo;
    if (value != null) {
      result
        ..add('todo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.done;
    if (value != null) {
      result
        ..add('done')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  TodoDto deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TodoDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'todo':
          result.todo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'done':
          result.done = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReminderDtoSerializer implements StructuredSerializer<ReminderDto> {
  @override
  final Iterable<Type> types = const [ReminderDto, _$ReminderDto];
  @override
  final String wireName = 'ReminderDto';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReminderDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.remId;
    if (value != null) {
      result
        ..add('remId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.reminderStart;
    if (value != null) {
      result
        ..add('reminderStart')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    value = object.days;
    if (value != null) {
      result
        ..add('days')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(ReminderDayDto)])));
    }
    value = object.selectedRepeat;
    if (value != null) {
      result
        ..add('selectedRepeat')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ReminderDto deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReminderDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'remId':
          result.remId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'reminderStart':
          result.reminderStart.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
        case 'days':
          result.days.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ReminderDayDto)]))!
              as BuiltList<Object?>);
          break;
        case 'selectedRepeat':
          result.selectedRepeat = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReminderDayDtoSerializer
    implements StructuredSerializer<ReminderDayDto> {
  @override
  final Iterable<Type> types = const [ReminderDayDto, _$ReminderDayDto];
  @override
  final String wireName = 'ReminderDayDto';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReminderDayDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.value;
    if (value != null) {
      result
        ..add('value')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  ReminderDayDto deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReminderDayDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$NoteModeEnumSerializer implements PrimitiveSerializer<NoteModeEnum> {
  @override
  final Iterable<Type> types = const <Type>[NoteModeEnum];
  @override
  final String wireName = 'NoteModeEnum';

  @override
  Object serialize(Serializers serializers, NoteModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  NoteModeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NoteModeEnum.valueOf(serialized as String);
}

class _$NoteCategoryEnumSerializer
    implements PrimitiveSerializer<NoteCategoryEnum> {
  @override
  final Iterable<Type> types = const <Type>[NoteCategoryEnum];
  @override
  final String wireName = 'NoteCategoryEnum';

  @override
  Object serialize(Serializers serializers, NoteCategoryEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  NoteCategoryEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NoteCategoryEnum.valueOf(serialized as String);
}

class _$NoteDto extends NoteDto {
  @override
  final String? id;
  @override
  final String? title;
  @override
  final BuiltList<TodoDto>? todoList;
  @override
  final String? description;
  @override
  final int? dateCreated;
  @override
  final int? dateModified;
  @override
  final int? dateDeleted;
  @override
  final int? dateArchived;
  @override
  final bool pinned;
  @override
  final ReminderDto? reminder;

  factory _$NoteDto([void Function(NoteDtoBuilder)? updates]) =>
      (new NoteDtoBuilder()..update(updates))._build();

  _$NoteDto._(
      {this.id,
      this.title,
      this.todoList,
      this.description,
      this.dateCreated,
      this.dateModified,
      this.dateDeleted,
      this.dateArchived,
      required this.pinned,
      this.reminder})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(pinned, r'NoteDto', 'pinned');
  }

  @override
  NoteDto rebuild(void Function(NoteDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NoteDtoBuilder toBuilder() => new NoteDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NoteDto &&
        id == other.id &&
        title == other.title &&
        todoList == other.todoList &&
        description == other.description &&
        dateCreated == other.dateCreated &&
        dateModified == other.dateModified &&
        dateDeleted == other.dateDeleted &&
        dateArchived == other.dateArchived &&
        pinned == other.pinned &&
        reminder == other.reminder;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc($jc(0, id.hashCode), title.hashCode),
                                    todoList.hashCode),
                                description.hashCode),
                            dateCreated.hashCode),
                        dateModified.hashCode),
                    dateDeleted.hashCode),
                dateArchived.hashCode),
            pinned.hashCode),
        reminder.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NoteDto')
          ..add('id', id)
          ..add('title', title)
          ..add('todoList', todoList)
          ..add('description', description)
          ..add('dateCreated', dateCreated)
          ..add('dateModified', dateModified)
          ..add('dateDeleted', dateDeleted)
          ..add('dateArchived', dateArchived)
          ..add('pinned', pinned)
          ..add('reminder', reminder))
        .toString();
  }
}

class NoteDtoBuilder implements Builder<NoteDto, NoteDtoBuilder> {
  _$NoteDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ListBuilder<TodoDto>? _todoList;
  ListBuilder<TodoDto> get todoList =>
      _$this._todoList ??= new ListBuilder<TodoDto>();
  set todoList(ListBuilder<TodoDto>? todoList) => _$this._todoList = todoList;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _dateCreated;
  int? get dateCreated => _$this._dateCreated;
  set dateCreated(int? dateCreated) => _$this._dateCreated = dateCreated;

  int? _dateModified;
  int? get dateModified => _$this._dateModified;
  set dateModified(int? dateModified) => _$this._dateModified = dateModified;

  int? _dateDeleted;
  int? get dateDeleted => _$this._dateDeleted;
  set dateDeleted(int? dateDeleted) => _$this._dateDeleted = dateDeleted;

  int? _dateArchived;
  int? get dateArchived => _$this._dateArchived;
  set dateArchived(int? dateArchived) => _$this._dateArchived = dateArchived;

  bool? _pinned;
  bool? get pinned => _$this._pinned;
  set pinned(bool? pinned) => _$this._pinned = pinned;

  ReminderDtoBuilder? _reminder;
  ReminderDtoBuilder get reminder =>
      _$this._reminder ??= new ReminderDtoBuilder();
  set reminder(ReminderDtoBuilder? reminder) => _$this._reminder = reminder;

  NoteDtoBuilder();

  NoteDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _todoList = $v.todoList?.toBuilder();
      _description = $v.description;
      _dateCreated = $v.dateCreated;
      _dateModified = $v.dateModified;
      _dateDeleted = $v.dateDeleted;
      _dateArchived = $v.dateArchived;
      _pinned = $v.pinned;
      _reminder = $v.reminder?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoteDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NoteDto;
  }

  @override
  void update(void Function(NoteDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NoteDto build() => _build();

  _$NoteDto _build() {
    _$NoteDto _$result;
    try {
      _$result = _$v ??
          new _$NoteDto._(
              id: id,
              title: title,
              todoList: _todoList?.build(),
              description: description,
              dateCreated: dateCreated,
              dateModified: dateModified,
              dateDeleted: dateDeleted,
              dateArchived: dateArchived,
              pinned: BuiltValueNullFieldError.checkNotNull(
                  pinned, r'NoteDto', 'pinned'),
              reminder: _reminder?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'todoList';
        _todoList?.build();

        _$failedField = 'reminder';
        _reminder?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'NoteDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TodoDto extends TodoDto {
  @override
  final String? todo;
  @override
  final bool? done;

  factory _$TodoDto([void Function(TodoDtoBuilder)? updates]) =>
      (new TodoDtoBuilder()..update(updates))._build();

  _$TodoDto._({this.todo, this.done}) : super._();

  @override
  TodoDto rebuild(void Function(TodoDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoDtoBuilder toBuilder() => new TodoDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TodoDto && todo == other.todo && done == other.done;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, todo.hashCode), done.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TodoDto')
          ..add('todo', todo)
          ..add('done', done))
        .toString();
  }
}

class TodoDtoBuilder implements Builder<TodoDto, TodoDtoBuilder> {
  _$TodoDto? _$v;

  String? _todo;
  String? get todo => _$this._todo;
  set todo(String? todo) => _$this._todo = todo;

  bool? _done;
  bool? get done => _$this._done;
  set done(bool? done) => _$this._done = done;

  TodoDtoBuilder();

  TodoDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _todo = $v.todo;
      _done = $v.done;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodoDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TodoDto;
  }

  @override
  void update(void Function(TodoDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TodoDto build() => _build();

  _$TodoDto _build() {
    final _$result = _$v ?? new _$TodoDto._(todo: todo, done: done);
    replace(_$result);
    return _$result;
  }
}

class _$ReminderDto extends ReminderDto {
  @override
  final int? remId;
  @override
  final BuiltList<int>? reminderStart;
  @override
  final BuiltList<ReminderDayDto>? days;
  @override
  final int? selectedRepeat;

  factory _$ReminderDto([void Function(ReminderDtoBuilder)? updates]) =>
      (new ReminderDtoBuilder()..update(updates))._build();

  _$ReminderDto._(
      {this.remId, this.reminderStart, this.days, this.selectedRepeat})
      : super._();

  @override
  ReminderDto rebuild(void Function(ReminderDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReminderDtoBuilder toBuilder() => new ReminderDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReminderDto &&
        remId == other.remId &&
        reminderStart == other.reminderStart &&
        days == other.days &&
        selectedRepeat == other.selectedRepeat;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, remId.hashCode), reminderStart.hashCode), days.hashCode),
        selectedRepeat.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReminderDto')
          ..add('remId', remId)
          ..add('reminderStart', reminderStart)
          ..add('days', days)
          ..add('selectedRepeat', selectedRepeat))
        .toString();
  }
}

class ReminderDtoBuilder implements Builder<ReminderDto, ReminderDtoBuilder> {
  _$ReminderDto? _$v;

  int? _remId;
  int? get remId => _$this._remId;
  set remId(int? remId) => _$this._remId = remId;

  ListBuilder<int>? _reminderStart;
  ListBuilder<int> get reminderStart =>
      _$this._reminderStart ??= new ListBuilder<int>();
  set reminderStart(ListBuilder<int>? reminderStart) =>
      _$this._reminderStart = reminderStart;

  ListBuilder<ReminderDayDto>? _days;
  ListBuilder<ReminderDayDto> get days =>
      _$this._days ??= new ListBuilder<ReminderDayDto>();
  set days(ListBuilder<ReminderDayDto>? days) => _$this._days = days;

  int? _selectedRepeat;
  int? get selectedRepeat => _$this._selectedRepeat;
  set selectedRepeat(int? selectedRepeat) =>
      _$this._selectedRepeat = selectedRepeat;

  ReminderDtoBuilder();

  ReminderDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _remId = $v.remId;
      _reminderStart = $v.reminderStart?.toBuilder();
      _days = $v.days?.toBuilder();
      _selectedRepeat = $v.selectedRepeat;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReminderDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReminderDto;
  }

  @override
  void update(void Function(ReminderDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReminderDto build() => _build();

  _$ReminderDto _build() {
    _$ReminderDto _$result;
    try {
      _$result = _$v ??
          new _$ReminderDto._(
              remId: remId,
              reminderStart: _reminderStart?.build(),
              days: _days?.build(),
              selectedRepeat: selectedRepeat);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'reminderStart';
        _reminderStart?.build();
        _$failedField = 'days';
        _days?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ReminderDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ReminderDayDto extends ReminderDayDto {
  @override
  final String? name;
  @override
  final bool? value;

  factory _$ReminderDayDto([void Function(ReminderDayDtoBuilder)? updates]) =>
      (new ReminderDayDtoBuilder()..update(updates))._build();

  _$ReminderDayDto._({this.name, this.value}) : super._();

  @override
  ReminderDayDto rebuild(void Function(ReminderDayDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReminderDayDtoBuilder toBuilder() =>
      new ReminderDayDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReminderDayDto &&
        name == other.name &&
        value == other.value;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), value.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReminderDayDto')
          ..add('name', name)
          ..add('value', value))
        .toString();
  }
}

class ReminderDayDtoBuilder
    implements Builder<ReminderDayDto, ReminderDayDtoBuilder> {
  _$ReminderDayDto? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  bool? _value;
  bool? get value => _$this._value;
  set value(bool? value) => _$this._value = value;

  ReminderDayDtoBuilder();

  ReminderDayDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReminderDayDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReminderDayDto;
  }

  @override
  void update(void Function(ReminderDayDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReminderDayDto build() => _build();

  _$ReminderDayDto _build() {
    final _$result = _$v ?? new _$ReminderDayDto._(name: name, value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
