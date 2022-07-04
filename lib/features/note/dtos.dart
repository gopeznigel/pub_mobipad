import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/material.dart' as material;

part 'dtos.g.dart';

class NoteStatusEnum extends EnumClass {
  const NoteStatusEnum._(String name) : super(name);

  static const NoteStatusEnum none = _$none;
  static const NoteStatusEnum initial = _$initial;
  static const NoteStatusEnum viewing = _$viewing;
  static const NoteStatusEnum editing = _$editing;
  static const NoteStatusEnum saving = _$saving;
  static const NoteStatusEnum saved = _$saved;
  static const NoteStatusEnum deleted = _$deleted;

  static Serializer<NoteStatusEnum> get serializer =>
      _$noteStatusEnumSerializer;
  static BuiltSet<NoteStatusEnum> get values => _$noteStatusEnumValues;
  static NoteStatusEnum valueOf(String name) => _$noteStatusEnumValueOf(name);
}

class NotePopupMenuEnum extends EnumClass {
  const NotePopupMenuEnum._(String name) : super(name);

  static const NotePopupMenuEnum reminder = _$reminder;
  static const NotePopupMenuEnum archive = _$archive;
  static const NotePopupMenuEnum unarchive = _$unarchive;
  static const NotePopupMenuEnum restore = _$restore;

  static Serializer<NotePopupMenuEnum> get serializer =>
      _$notePopupMenuEnumSerializer;
  static BuiltSet<NotePopupMenuEnum> get values => _$notePopupMenuEnumValues;
  static NotePopupMenuEnum valueOf(String name) =>
      _$notePopupMenuEnumValueOf(name);
}

extension NoteStatusEnumX on NoteStatusEnum {
  bool get isNone => this == NoteStatusEnum.none;
  bool get isInitial => this == NoteStatusEnum.initial;
  bool get isViewing => this == NoteStatusEnum.viewing;
  bool get isEditing => this == NoteStatusEnum.editing;
  bool get isSaving => this == NoteStatusEnum.saving;
  bool get isSaved => this == NoteStatusEnum.saved;
  bool get isDeleted => this == NoteStatusEnum.deleted;
}

abstract class NoteMenuDto implements Built<NoteMenuDto, NoteMenuDtoBuilder> {
  factory NoteMenuDto([void Function(NoteMenuDtoBuilder b) updates]) =
      _$NoteMenuDto;

  NoteMenuDto._();

  static Serializer<NoteMenuDto> get serializer => _$noteMenuDtoSerializer;

  NotePopupMenuEnum? get menu;
  material.IconData? get icon;
}
