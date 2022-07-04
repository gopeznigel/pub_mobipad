// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtos.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SelectionModeEnum _$none = const SelectionModeEnum._('none');
const SelectionModeEnum _$multiple = const SelectionModeEnum._('multiple');

SelectionModeEnum _$selectionModeEnumValueOf(String name) {
  switch (name) {
    case 'none':
      return _$none;
    case 'multiple':
      return _$multiple;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<SelectionModeEnum> _$selectionModeEnumValues =
    new BuiltSet<SelectionModeEnum>(const <SelectionModeEnum>[
  _$none,
  _$multiple,
]);

const MultiPinEnum _$disabled = const MultiPinEnum._('disabled');
const MultiPinEnum _$multiPin = const MultiPinEnum._('multiPin');
const MultiPinEnum _$multiUnpin = const MultiPinEnum._('multiUnpin');

MultiPinEnum _$multiPinEnumValueOf(String name) {
  switch (name) {
    case 'disabled':
      return _$disabled;
    case 'multiPin':
      return _$multiPin;
    case 'multiUnpin':
      return _$multiUnpin;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<MultiPinEnum> _$multiPinEnumValues =
    new BuiltSet<MultiPinEnum>(const <MultiPinEnum>[
  _$disabled,
  _$multiPin,
  _$multiUnpin,
]);

Serializer<SelectionModeEnum> _$selectionModeEnumSerializer =
    new _$SelectionModeEnumSerializer();
Serializer<MultiPinEnum> _$multiPinEnumSerializer =
    new _$MultiPinEnumSerializer();

class _$SelectionModeEnumSerializer
    implements PrimitiveSerializer<SelectionModeEnum> {
  @override
  final Iterable<Type> types = const <Type>[SelectionModeEnum];
  @override
  final String wireName = 'SelectionModeEnum';

  @override
  Object serialize(Serializers serializers, SelectionModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  SelectionModeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SelectionModeEnum.valueOf(serialized as String);
}

class _$MultiPinEnumSerializer implements PrimitiveSerializer<MultiPinEnum> {
  @override
  final Iterable<Type> types = const <Type>[MultiPinEnum];
  @override
  final String wireName = 'MultiPinEnum';

  @override
  Object serialize(Serializers serializers, MultiPinEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  MultiPinEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MultiPinEnum.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
