// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtos.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NoteStatusEnum _$none = const NoteStatusEnum._('none');
const NoteStatusEnum _$initial = const NoteStatusEnum._('initial');
const NoteStatusEnum _$viewing = const NoteStatusEnum._('viewing');
const NoteStatusEnum _$editing = const NoteStatusEnum._('editing');
const NoteStatusEnum _$saving = const NoteStatusEnum._('saving');
const NoteStatusEnum _$saved = const NoteStatusEnum._('saved');
const NoteStatusEnum _$deleted = const NoteStatusEnum._('deleted');

NoteStatusEnum _$noteStatusEnumValueOf(String name) {
  switch (name) {
    case 'none':
      return _$none;
    case 'initial':
      return _$initial;
    case 'viewing':
      return _$viewing;
    case 'editing':
      return _$editing;
    case 'saving':
      return _$saving;
    case 'saved':
      return _$saved;
    case 'deleted':
      return _$deleted;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<NoteStatusEnum> _$noteStatusEnumValues =
    new BuiltSet<NoteStatusEnum>(const <NoteStatusEnum>[
  _$none,
  _$initial,
  _$viewing,
  _$editing,
  _$saving,
  _$saved,
  _$deleted,
]);

const NotePopupMenuEnum _$reminder = const NotePopupMenuEnum._('reminder');
const NotePopupMenuEnum _$archive = const NotePopupMenuEnum._('archive');
const NotePopupMenuEnum _$unarchive = const NotePopupMenuEnum._('unarchive');
const NotePopupMenuEnum _$restore = const NotePopupMenuEnum._('restore');

NotePopupMenuEnum _$notePopupMenuEnumValueOf(String name) {
  switch (name) {
    case 'reminder':
      return _$reminder;
    case 'archive':
      return _$archive;
    case 'unarchive':
      return _$unarchive;
    case 'restore':
      return _$restore;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<NotePopupMenuEnum> _$notePopupMenuEnumValues =
    new BuiltSet<NotePopupMenuEnum>(const <NotePopupMenuEnum>[
  _$reminder,
  _$archive,
  _$unarchive,
  _$restore,
]);

Serializer<NoteStatusEnum> _$noteStatusEnumSerializer =
    new _$NoteStatusEnumSerializer();
Serializer<NotePopupMenuEnum> _$notePopupMenuEnumSerializer =
    new _$NotePopupMenuEnumSerializer();
Serializer<NoteMenuDto> _$noteMenuDtoSerializer = new _$NoteMenuDtoSerializer();

class _$NoteStatusEnumSerializer
    implements PrimitiveSerializer<NoteStatusEnum> {
  @override
  final Iterable<Type> types = const <Type>[NoteStatusEnum];
  @override
  final String wireName = 'NoteStatusEnum';

  @override
  Object serialize(Serializers serializers, NoteStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  NoteStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NoteStatusEnum.valueOf(serialized as String);
}

class _$NotePopupMenuEnumSerializer
    implements PrimitiveSerializer<NotePopupMenuEnum> {
  @override
  final Iterable<Type> types = const <Type>[NotePopupMenuEnum];
  @override
  final String wireName = 'NotePopupMenuEnum';

  @override
  Object serialize(Serializers serializers, NotePopupMenuEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  NotePopupMenuEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NotePopupMenuEnum.valueOf(serialized as String);
}

class _$NoteMenuDtoSerializer implements StructuredSerializer<NoteMenuDto> {
  @override
  final Iterable<Type> types = const [NoteMenuDto, _$NoteMenuDto];
  @override
  final String wireName = 'NoteMenuDto';

  @override
  Iterable<Object?> serialize(Serializers serializers, NoteMenuDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.menu;
    if (value != null) {
      result
        ..add('menu')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(NotePopupMenuEnum)));
    }
    value = object.icon;
    if (value != null) {
      result
        ..add('icon')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(material.IconData)));
    }
    return result;
  }

  @override
  NoteMenuDto deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NoteMenuDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'menu':
          result.menu = serializers.deserialize(value,
                  specifiedType: const FullType(NotePopupMenuEnum))
              as NotePopupMenuEnum?;
          break;
        case 'icon':
          result.icon = serializers.deserialize(value,
                  specifiedType: const FullType(material.IconData))
              as material.IconData?;
          break;
      }
    }

    return result.build();
  }
}

class _$NoteMenuDto extends NoteMenuDto {
  @override
  final NotePopupMenuEnum? menu;
  @override
  final material.IconData? icon;

  factory _$NoteMenuDto([void Function(NoteMenuDtoBuilder)? updates]) =>
      (new NoteMenuDtoBuilder()..update(updates))._build();

  _$NoteMenuDto._({this.menu, this.icon}) : super._();

  @override
  NoteMenuDto rebuild(void Function(NoteMenuDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NoteMenuDtoBuilder toBuilder() => new NoteMenuDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NoteMenuDto && menu == other.menu && icon == other.icon;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, menu.hashCode), icon.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NoteMenuDto')
          ..add('menu', menu)
          ..add('icon', icon))
        .toString();
  }
}

class NoteMenuDtoBuilder implements Builder<NoteMenuDto, NoteMenuDtoBuilder> {
  _$NoteMenuDto? _$v;

  NotePopupMenuEnum? _menu;
  NotePopupMenuEnum? get menu => _$this._menu;
  set menu(NotePopupMenuEnum? menu) => _$this._menu = menu;

  material.IconData? _icon;
  material.IconData? get icon => _$this._icon;
  set icon(material.IconData? icon) => _$this._icon = icon;

  NoteMenuDtoBuilder();

  NoteMenuDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _menu = $v.menu;
      _icon = $v.icon;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NoteMenuDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NoteMenuDto;
  }

  @override
  void update(void Function(NoteMenuDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NoteMenuDto build() => _build();

  _$NoteMenuDto _build() {
    final _$result = _$v ?? new _$NoteMenuDto._(menu: menu, icon: icon);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
