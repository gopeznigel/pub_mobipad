import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dtos.g.dart';

abstract class NoteDto implements Built<NoteDto, NoteDtoBuilder> {
  factory NoteDto([void Function(NoteDtoBuilder b) updates]) = _$NoteDto;

  NoteDto._();

  static Serializer<NoteDto> get serializer => _$noteDtoSerializer;

  String? get id;
  String? get title;
  BuiltList<TodoDto>? get todoList;
  String? get description;
  int? get dateCreated;
  int? get dateModified;
  int? get dateDeleted;
  int? get dateArchived;
  bool get pinned;
  ReminderDto? get reminder;
}

abstract class TodoDto implements Built<TodoDto, TodoDtoBuilder> {
  factory TodoDto([void Function(TodoDtoBuilder b) updates]) = _$TodoDto;

  TodoDto._();

  static Serializer<TodoDto> get serializer => _$todoDtoSerializer;

  String? get todo;
  bool? get done;
}

abstract class ReminderDto implements Built<ReminderDto, ReminderDtoBuilder> {
  factory ReminderDto([void Function(ReminderDtoBuilder b) updates]) =
      _$ReminderDto;

  ReminderDto._();

  static Serializer<ReminderDto> get serializer => _$reminderDtoSerializer;

  int? get remId;
  BuiltList<int>? get reminderStart;
  BuiltList<ReminderDayDto>? get days;
  int? get selectedRepeat;
}

abstract class ReminderDayDto
    implements Built<ReminderDayDto, ReminderDayDtoBuilder> {
  factory ReminderDayDto([void Function(ReminderDayDtoBuilder b) updates]) =
      _$ReminderDayDto;

  ReminderDayDto._();

  static Serializer<ReminderDayDto> get serializer =>
      _$reminderDayDtoSerializer;

  String? get name;
  bool? get value;
}

class NoteModeEnum extends EnumClass {
  const NoteModeEnum._(String name) : super(name);

  static const NoteModeEnum note = _$note;
  static const NoteModeEnum todo = _$todo;

  static Serializer<NoteModeEnum> get serializer => _$noteModeEnumSerializer;
  static BuiltSet<NoteModeEnum> get values => _$noteModeEnumValues;
  static NoteModeEnum valueOf(String name) => _$noteModeEnumValueOf(name);
}

extension NoteModeEnumX on NoteModeEnum {
  bool get isNote => this == NoteModeEnum.note;
  bool get isTodo => this == NoteModeEnum.todo;
}

class NoteCategoryEnum extends EnumClass {
  const NoteCategoryEnum._(String name) : super(name);

  static const NoteCategoryEnum active = _$active;
  static const NoteCategoryEnum archived = _$archived;
  static const NoteCategoryEnum trashed = _$trashed;

  static Serializer<NoteCategoryEnum> get serializer =>
      _$noteCategoryEnumSerializer;
  static BuiltSet<NoteCategoryEnum> get values => _$noteCategoryEnumValues;
  static NoteCategoryEnum valueOf(String name) =>
      _$noteCategoryEnumValueOf(name);
}

extension NoteCategoryEnumX on NoteCategoryEnum {
  bool get isActive => this == NoteCategoryEnum.active;
  bool get isArchived => this == NoteCategoryEnum.archived;
  bool get isTrashed => this == NoteCategoryEnum.trashed;
}
